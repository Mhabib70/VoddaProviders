import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Helpers/token-methods.dart';
import 'package:vodda_providers/Logic/Models/notification.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';
import 'package:vodda_providers/laravel_echo/laravel_echo.dart';
import 'package:vodda_providers/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:universal_html/html.dart' as html;

// import 'dart:js' as js;

class NotificationController extends GetxController
    with WidgetsBindingObserver {
  static final backgroundService = FlutterBackgroundService();
  // static bool _isinitial=true;

  @pragma('vm:entry-point')
  static initSocket({bool isBackgroundSocket = false}) async {
    // if(_isinitial){
    print('initSocket');
    HttpOverrides.global = new MyHttpOverrides();

    IO.Socket socket = IO.io(
      'https://chatbama.ir:6001',
      IO.OptionBuilder().disableAutoConnect().setTransports([
        'websocket',
      ]).build(),
    );

    // Create echo instance
    Echo echo = new Echo(
      broadcaster: EchoBroadcasterType.SocketIO,
      client: socket,
    );

    print('listen to channel');
    List<String> servicesToken = await Token.getServicesToken();
    for (int i = 0; i < servicesToken.length; i++) {
      echo.channel('user-channel${servicesToken[i]}').listen('.UserEvent', (e) {
        if (isBackgroundSocket)
          echoChannelBackground(e['data']);
        else
          echoChannelForground(e['data']);
      });
    }

    String? userToken = await Token.getNotifToken();
    print('userBackground>>${userToken}');

    echo.channel('user-channel${userToken}').listen('.UserEvent', (e) {
      if (isBackgroundSocket)
        echoChannelBackground(e['data']);
      else
        echoChannelForground(e['data']);
    });

    String? provinceToken = await Token.getProvinceNotif();
    echo.channel('user-channel${provinceToken}').listen('.UserEvent', (e) {
      if (isBackgroundSocket)
        echoChannelBackground(e['data']);
      else
        echoChannelForground(e['data']);
    });

    //@smae1993 commented
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     print('ConnectivityResult.none');
    //     echo.leaveChannel('user-channel${userToken}');
    //     for (int i = 0; i < servicesToken.length; i++) {
    //       echo.leaveChannel('user-channel${servicesToken[i]}');
    //     }
    //     socket.clearListeners();
    //   }
    // });
  }

  static echoChannelForground(data) {
    SocketNotification notification = SocketNotification.fromJson(data);
    print('forgroundsocket>>>>${data}');
    switch (notification.type) {
      case 'update_order':
        MainController.getOrder(int.parse(notification.fId!));
        break;
      case 'add_order':
        MainController.getOrder(int.parse(notification.fId!));
        break;
      case 'delete_order':
        MainController.sugestedOrders.remove(int.parse(notification.fId!));
        break;
      case 'cancel_order':
        UserController.getUser();
        MainController.getOrder(int.parse(notification.fId!));
        if (MainController.sugestedOrders.containsKey(
          int.parse(notification.fId!),
        ))
          MainController.sugestedOrders.remove(int.parse(notification.fId!));
        break;
      case 'update_settlement':
        MainController.getSettlement();
        UserController.getUser();
        break;
      case 'update_provider':
        UserController.getUser();
        MainController.getFinancial();
        MainController.getWallet();
        break;
    }

    if (notification.isAudioAlert == '1') {
      AssetsAudioPlayer.newPlayer().open(Audio("assets/mp3/notif.mpeg"));
    }
    print('listen alert');
    if (notification.isShowAlert == '1') {
      showNotificationWeb(notification.message);
      switch (notification.status) {
        case 'error':
          showSnackbar(snackTypes.error, notification.message);
          break;
        case 'success':
          showSnackbar(snackTypes.success, notification.message);
          break;
        case 'info':
          showSnackbar(snackTypes.info, notification.message);
          break;
        case 'warning':
          showSnackbar(snackTypes.warning, notification.message);
          break;
      }
    }
  }

  @pragma('vm:entry-point')
  static echoChannelBackground(data) {
    SocketNotification notification = SocketNotification.fromJson(data);
    print('backgroundsocket>>>>${data}');

    if (notification.isShowAlert == '1') {
      print('listen alert');
      switch (notification.status) {
        case 'error':
          showNotificationApp(notification.message!, errorColor);
          break;
        case 'success':
          showNotificationApp(notification.message!, successColor);
          break;
        case 'info':
          showNotificationApp(notification.message!, infoColor);
          break;
        case 'warning':
          showNotificationApp(notification.message!, warningColor);
          break;
      }
    }
  }

  static Future<void> initBackgroundService() async {
    // if(!await backgroundService.isRunning()){

    print('initBackgroundService');

    await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: AppController.primaryColor,
          ledColor: AppController.primaryColor,
        ),
      ],
      debug: false,
    );

    await backgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStartBackground,

        // auto start service
        autoStart: false,
        isForegroundMode: false,

        notificationChannelId: 'alerts',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: false,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStartBackground,

        // you have to enable background fetch capability on xcode project
        onBackground: (ServiceInstance service) {
          WidgetsFlutterBinding.ensureInitialized();
          print('FLUTTER BACKGROUND FETCH');

          return true;
        },
      ),
    );

    // backgroundService.startService();

    // }
  }

  @pragma('vm:entry-point')
  static void onStartBackground(ServiceInstance service) async {
    print('***onStartBackgroundService**');
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    initSocket(isBackgroundSocket: true);

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        print('setAsForeground');
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        print('setAsBackground');
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      print('stopServiceBackground');
      service.stopSelf();
    });

    // bring to foreground
    // Timer.periodic(const Duration(seconds: 10), (timer) async {//remove
    //
    // //
    // //   print('hello');
    // //   // showNotificationApp('Timer.periodic', Colors.red);
    // //
    // //   // if (service is AndroidServiceInstance) {
    // //   //   service.setForegroundNotificationInfo(
    // //   //     title: "My App Service",
    // //   //     content: "Updated at ${DateTime.now()}",
    // //   //   );
    // //   // }
    // //
    // //   /// you can see this log in logcat
    // //   // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    // //
    // //   // test using external plugin
    // //   // final deviceInfo = DeviceInfoPlugin();
    // //   // String? device;
    // //   // if (Platform.isAndroid) {
    // //   //   // final androidInfo = await deviceInfo.androidInfo;
    // //   //   device = 'androidInfo.model';
    // //   // }
    // //   //
    // //   // if (Platform.isIOS) {
    // //   //   // final iosInfo = await deviceInfo.iosInfo;
    // //   //   device = 'iosInfo.model';
    // //   // }
    // //   //
    // //   // service.invoke(
    // //   //   'update',
    // //   //   {
    // //   //     "current_date": DateTime.now().toIso8601String(),
    // //   //     "device": device,
    // //   //   },
    // //   // );
    // });
  }

  static Future<bool> displayNotificationPermission() async {
    bool userAuthorized = false;
    BuildContext context = Get.context!;
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'Get Notified!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/animated-bell.gif',
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Allow Awesome Notifications to send you beautiful notifications!',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Deny',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                userAuthorized = true;
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Allow',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @pragma('vm:entry-point')
  static showNotificationApp(String text, Color color) async {
    print('notifText>>$text');
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationPermission();
    if (!isAllowed) return;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1, // -1 is replaced by a random number
        channelKey: 'alerts',
        title: text,
        // body:"aaaaaa",
        // bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        // largeIcon:
        // 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        // 'asset://assets/logos/logo.png',
        notificationLayout: NotificationLayout.Default,
        payload: {'notificationId': '1234567890'},
      ),
      actionButtons: [
        // NotificationActionButton(key: 'REDIRECT', label: 'Redirect',),
        // NotificationActionButton(
        //     key: 'REPLY',
        //     label: 'Reply Message',
        //     requireInputText: true,
        //     actionType: ActionType.SilentAction
        // ),
        NotificationActionButton(
          key: 'بستن',
          label: 'بستن',
          actionType: ActionType.DismissAction,
          isDangerousOption: true,
        ),
      ],
    );
  }

  static showNotificationWeb(var text) {
    if (kIsWeb) {
      // js.context.callMethod('persistentNotification',[text]);
      var element = html.document.getElementById('notificationDiv');
      element!.innerHtml = text;
      element.click();
      element.innerHtml = '';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    print('onInitNotif');
    initSocket(isBackgroundSocket: false);
    if (!kIsWeb) await initBackgroundService();

    backgroundService.invoke('stopService');
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    print('onCloseNotif');
    if (!kIsWeb) backgroundService.startService();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print('appResume');
        if (!kIsWeb) backgroundService.invoke('stopService');
        break;
      case AppLifecycleState.inactive:
        print('appInactive');
        if (!kIsWeb) backgroundService.startService();
        break;
      case AppLifecycleState.paused:
        print('appPause');
        if (!kIsWeb) backgroundService.startService();
        break;
      case AppLifecycleState.detached:
        print('appDeatached');
        if (!kIsWeb) backgroundService.startService();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
