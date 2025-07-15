import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Helpers/api-methods.dart';
import 'package:vodda_providers/Logic/Models/Settlement.dart';
import 'package:vodda_providers/Logic/Models/account.dart';
import 'package:vodda_providers/Logic/Models/date.dart';
import 'package:vodda_providers/Logic/Models/financial.dart';
import 'package:vodda_providers/Logic/Models/free-time.dart';
import 'package:vodda_providers/Logic/Models/holiday.dart';
import 'package:vodda_providers/Logic/Models/option.dart';
import 'package:vodda_providers/Logic/Models/order-document.dart';
import 'package:vodda_providers/Logic/Models/order.dart';
import 'package:vodda_providers/Logic/Models/service-question.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Logic/Models/wallet.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class MainController extends GetxController {
  static RxMap<int, Order> myOrders = <int, Order>{}.obs;
  static RxMap<String, Date> myOrdersDates = <String, Date>{}.obs;

  static RxMap<int, Order> sugestedOrders = <int, Order>{}.obs;
  static RxnString filterDay = RxnString();
  static RxnInt filterType = RxnInt();
  static Rxn<Order> filter = Rxn<Order>();

  static RxBool getAllCash = true.obs;

  static RxList<Settlement> mySettlements = <Settlement>[].obs;
  static RxList<Financial> myFinancial = <Financial>[].obs;
  static RxList<Wallet> mywallets = <Wallet>[].obs;
  static Settlement newTransaction = Settlement();

  static RxList<Account> myAccounts = <Account>[].obs;

  static RxMap<int, Service> myServices = <int, Service>{}.obs;
  static RxMap<int, ServiceQuestion> myQuestions = <int, ServiceQuestion>{}.obs;
  static RxMap<int, Option> myOptions = <int, Option>{}.obs;

  static Map<int, String> days = {
    0: 'شنبه',
    1: 'یکشنبه',
    2: 'دوشنبه',
    3: 'سه شنبه',
    4: 'چهارشنبه',
    5: 'پنجشنبه',
    6: 'جمعه',
  };

  static RxMap<int, FreeTime> freeTimes = <int, FreeTime>{}.obs;
  static RxMap<int, Holiday> holidays = <int, Holiday>{}.obs;
  static Map<int, bool> years = <int, bool>{};

  static Rx<Duration> timerDuration = Duration(
    hours: 00,
    minutes: 00,
    seconds: 00,
  ).obs;
  static var timer = Timer(Duration(days: 999), () {});

  static getUserInfo() async {
    var response = await RestApi.post(getUserInfoUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOrders.value = <int, Order>{};
        for (var json in response!.data['data']['myList']) {
          Order order = Order.fromJson(json);
          myOrders[order.id!] = order;
        }
        myOrdersDates.value = <String, Date>{};
        for (var json in response.data['data']['myListWithDate']) {
          Date date = Date.fromJson(json);
          myOrdersDates[date.value!] = date;
        }
        sugestedOrders.value = <int, Order>{};
        for (var json in response.data['data']['suggestList']) {
          Order order = Order.fromJson(json);
          sugestedOrders[order.id!] = order;
        }
        mySettlements.value = <Settlement>[];
        for (var json in response.data['data']['mySettlement']) {
          Settlement settlement = Settlement.fromJson(json);
          mySettlements.add(settlement);
        }
        mywallets.value = <Wallet>[];
        for (var json in response.data['data']['myWallet']) {
          Wallet wallet = Wallet.fromJson(json);
          mywallets.add(wallet);
        }
        myFinancial.value = <Financial>[];
        for (var json in response.data['data']['myFinancial']) {
          Financial financial = Financial.fromJson(json);
          myFinancial.add(financial);
        }
        myAccounts.value = <Account>[];
        for (var json in response.data['data']['myAccount']) {
          Account account = Account.fromJson(json);
          myAccounts.add(account);
        }
      },
      printResponse: true,
    );
  }

  static setTime(Order order) {
    timer.cancel();
    timerDuration.value = Duration(seconds: 0);
    if (order.state == 2 && order.service!.typePlace == 2) {
      DateTime dateTime = DateTime.parse('${order.date} ${order.time}');

      if (dateTime.difference(DateTime.now()).inSeconds > 0) {
        timerDuration.value = Duration(
          seconds: dateTime.difference(DateTime.now()).inSeconds,
        );
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          final seconds = timerDuration.value.inSeconds - 1;
          if (seconds < 0) {
            timer.cancel();
          } else {
            timerDuration.value = Duration(seconds: seconds);
          }
        });
      }
    }
  }

  static getTime() {
    final hours = timerDuration.value.inHours.toString().padLeft(2, '0');
    final minutes = timerDuration.value.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = timerDuration.value.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  static meetOrder(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      meetOrderUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () async {
        showSnackbar(snackTypes.info, response!.data['message']);
        await launchUrl(
          Uri.parse(response.data['data']),
          mode: LaunchMode.externalApplication,
        );
      },
    );
    AppController.isLoading.value = false;
  }

  static callOrder(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      callOrderUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        showSnackbar(snackTypes.info, response!.data['message']);
      },
    );
    AppController.isLoading.value = false;
  }

  static callUser(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      callPrivateUrl,
      body: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        showSnackbar(snackTypes.info, response!.data['message']);
      },
    );
    AppController.isLoading.value = false;
  }

  static getSugestedOrders() async {
    var response = await RestApi.post(suggestOrdersUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        sugestedOrders.value = <int, Order>{};
        for (var json in response!.data['data']) {
          Order order = Order.fromJson(json);
          sugestedOrders[order.id!] = order;
        }
      },
      printResponse: true,
    );
  }

  static setOnline() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(setOnlineUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        if (UserController.user.value.online == 1)
          UserController.user.value.online = 0;
        else
          UserController.user.value.online = 1;
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
  }

  static getMyOrders() async {
    var response = await RestApi.post(myOrdersUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOrders.value = <int, Order>{};
        for (var json in response!.data['data']) {
          Order order = Order.fromJson(json);
          myOrders[order.id!] = order;
        }
      },
    );
  }

  static getMyOrdersWithDate() async {
    var response = await RestApi.post(myOrdersWithDateUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOrdersDates.value = <String, Date>{};
        for (var json in response!.data['data']) {
          Date date = Date.fromJson(json);
          myOrdersDates[date.value!] = date;
        }
      },
      printResponse: true,
    );
  }

  static cancelOrder(Order order) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      cancelOrderUrl,
      body: {'order_id': order.id!, 'description': order.cancelDescription},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        // myOrders.remove(order.id);
        showSnackbar(snackTypes.info, response!.data['message']);
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static hideRequestedOrders(Order order) async {
    var response = await RestApi.post(
      unSuggestOrdersUrl,
      body: {'order_id': order.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        sugestedOrders.remove(order.id);
      },
    );
  }

  static acceptOrder(Order order) async {
    var response = await RestApi.post(
      acceptOrderUrl,
      body: {
        'order_id': order.id,
        'price': order.price,
        'time': order.durationTime,
        'description': order.providerDescription,
      },
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        order = Order.fromJson(response!.data['data']['order']);
        Date date = Date.fromJson(response.data['data']['date']);

        if (order.type == 0) {
          sugestedOrders[order.id!] = order;
        } else {
          sugestedOrders.remove(order.id);
          myOrders[order.id!] = order;
          if (!myOrdersDates.keys.contains(order.date!))
            myOrdersDates[order.date!] = date;
          myOrdersDates[order.date]!.orderIds.addIf(
            !myOrdersDates[order.date]!.orderIds.contains(order.id),
            order.id!,
          );
        }
      },
      printResponse: true,
    );
  }

  static notAcceptOrder(Order order) async {
    var response = await RestApi.post(
      notAcceptOrderUrl,
      body: {'order_id': order.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        // order=Order.fromJson(response!.data['data']);
        sugestedOrders.remove(order.id!);
        //   myOrders[order.id!]=order;
      },
    );
  }

  static startOrder(Order order) async {
    var response = await RestApi.post(
      startOrderUrl,
      body: {'order_id': order.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        order = Order.fromJson(response!.data['data']);
        myOrders[order.id!] = order;
        showSnackbar(snackTypes.success, response.data['message']);
      },
    );
  }

  static getOrder(int orderId, {bool hasLoading = false}) async {
    if (hasLoading) AppController.isLoading.value = true;
    var response = await RestApi.post(getOrderUrl, body: {'order_id': orderId});
    RestApi.responseHandler(
      response: response,
      printResponse: true,
      successCallback: () async {
        await getMyOrdersWithDate();

        if (response!.data['data'] == null) {
          if (myOrders.containsKey(orderId)) myOrders.remove(orderId);
          if (sugestedOrders.containsKey(orderId))
            sugestedOrders.remove(orderId);
          return;
        }
        Order order = Order.fromJson(response.data['data']);

        if (myOrders.containsKey(orderId)) {
          myOrders[orderId] = order;

          if (order.state == 3) {
            UserController.getUser();
          }
          if (order.state == 1) {
            myOrders.remove(orderId);
            sugestedOrders[orderId] = order;
          }
        } else {
          if (order.state == 2) {
            myOrders[orderId] = order;
            sugestedOrders.remove(orderId);
          } else
            sugestedOrders[orderId] = order;
        }
      },
    );

    if (hasLoading) AppController.isLoading.value = false;
  }

  static getSettlement() async {
    var response = await RestApi.get(mySettlementUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        mySettlements.value = <Settlement>[];
        for (var json in response!.data['data']) {
          Settlement settlement = Settlement.fromJson(json);
          mySettlements.add(settlement);
        }
      },
    );
  }

  static getWallet() async {
    var response = await RestApi.get(myWalletUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        mywallets.value = <Wallet>[];
        for (var json in response!.data['data']) {
          Wallet wallet = Wallet.fromJson(json);
          mywallets.add(wallet);
        }
      },
    );
  }

  static getFinancial() async {
    var response = await RestApi.get(myFinancialUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myFinancial.value = <Financial>[];
        for (var json in response!.data['data']) {
          Financial financial = Financial.fromJson(json);
          myFinancial.add(financial);
        }
      },
    );
  }

  static getWalletCash() async {
    if (newTransaction.accountId == null)
      showSnackbar(snackTypes.error, 'حساب خود را انتخاب نمایید');
    else if (newTransaction.amount == '0' ||
        newTransaction.amount == null ||
        newTransaction.amount == '')
      showSnackbar(snackTypes.error, 'مبلغ درخواستی باید بیشتر از 0 باشد');
    else if (int.parse(newTransaction.amount!) >
        int.parse(UserController.user.value.totalWallet!))
      showSnackbar(snackTypes.error, 'مقدار موجودی کمتر از مبلغ درخواستی است');
    else {
      Navigator.pop(Get.context!);
      var response = await RestApi.post(
        getWalletCashUrl,
        body: {
          'amount': newTransaction.amount,
          'account_id': newTransaction.accountId,
        },
      );
      RestApi.responseHandler(
        response: response,
        successCallback: () {
          // Settlement settlement=Settlement.fromJson(response!.data['data']);
          // mySettlements.add(settlement);
          showSnackbar(snackTypes.success, response!.data['message']);
        },
      );
    }
  }

  static getAccounts() async {
    var response = await RestApi.get(myAccountsUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myAccounts.value = <Account>[];
        for (var json in response!.data['data']) {
          Account account = Account.fromJson(json);
          myAccounts.add(account);
        }
      },
    );
  }

  static addAccount(Account newAccount) async {
    var response = await RestApi.post(addAccountUrl, body: newAccount.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Account account = Account.fromJson(response!.data['data']);
        myAccounts.add(account);
      },
    );
  }

  static updateAccount(Account account) async {
    var response = await RestApi.post(updateAccountUrl, body: account.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Account account = Account.fromJson(response!.data['data']);
        myAccounts[myAccounts.indexWhere(
              (element) => element.id == account.id,
            )] =
            account;
      },
    );
  }

  static removeAccount(Account account) async {
    var response = await RestApi.post(
      removeAccountUrl,
      body: {'account_id': account.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myAccounts.remove(account);
      },
    );
  }

  static getFreeTimes() async {
    AppController.isLoading.value = true;
    var response = await RestApi.get(getFreeTimesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        freeTimes.value = <int, FreeTime>{};
        for (var json in response!.data['data']) {
          FreeTime freeTime = FreeTime.fromJson(json);
          freeTimes[freeTime.id!] = freeTime;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static addFreeTime(FreeTime freeTime) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(addFreeTimeUrl, body: freeTime.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        freeTimes.value = <int, FreeTime>{};
        for (var json in response!.data['data']) {
          FreeTime freeTime = FreeTime.fromJson(json);
          freeTimes[freeTime.id!] = freeTime;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static updateFreeTime(FreeTime freeTime) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      updateFreeTimeUrl,
      body: freeTime.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        freeTimes.value = <int, FreeTime>{};
        for (var json in response!.data['data']) {
          FreeTime freeTime = FreeTime.fromJson(json);
          freeTimes[freeTime.id!] = freeTime;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static deleteFreeTime(FreeTime freeTime) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      deleteFreeTimeUrl,
      body: {'id': freeTime.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        freeTimes.value = <int, FreeTime>{};
        for (var json in response!.data['data']) {
          FreeTime freeTime = FreeTime.fromJson(json);
          freeTimes[freeTime.id!] = freeTime;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static getHolidays() async {
    AppController.isLoading.value = true;
    var response = await RestApi.get(getHolidaysUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        holidays.value = <int, Holiday>{};
        for (var json in response!.data['data']) {
          Holiday holiday = Holiday.fromJson(json);
          holidays[holiday.id!] = holiday;
        }
      },
      printResponse: true,
    );
    var res = await RestApi.get(getYearsUrl);
    RestApi.responseHandler(
      response: res,
      successCallback: () {
        for (var json in res!.data['data']) {
          years[json['title']] = json['is_kabise'];
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static addHoliday(Holiday holiday) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(addHolidayUrl, body: holiday.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        holidays.value = <int, Holiday>{};
        for (var json in response!.data['data']) {
          Holiday holiday = Holiday.fromJson(json);
          holidays[holiday.id!] = holiday;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static updateHoliday(Holiday holiday) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(updateHolidayUrl, body: holiday.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        holidays.value = <int, Holiday>{};
        for (var json in response!.data['data']) {
          Holiday holiday = Holiday.fromJson(json);
          holidays[holiday.id!] = holiday;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static deleteHoliday(Holiday holiday) async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      deleteHolidayUrl,
      body: {'id': holiday.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        holidays.value = <int, Holiday>{};
        for (var json in response!.data['data']) {
          Holiday holiday = Holiday.fromJson(json);
          holidays[holiday.id!] = holiday;
        }
      },
    );
    AppController.isLoading.value = false;
  }

  static getMyServices() async {
    // if(myServices.length==0){
    AppController.isLoading.value = true;
    var response = await RestApi.get(getMyServicesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        for (var json in response!.data['data']) {
          Service service = Service.fromJson(json);
          myServices[service.id!] = service;
        }
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
    // }
  }

  static updateService(Service service) async {
    var response = await RestApi.post(updateServiceUrl, body: service.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Service service = Service.fromJson(response!.data['data']);
        myServices[service.id!] = service;
      },
      printResponse: true,
    );
  }

  static getServiceQuestions(int serviceId) async {
    // if(myServices[serviceId]!.questionIds.length==0){
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      getServiceQuestionsUrl,
      body: {'service_id': serviceId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        for (var json in response!.data['data']) {
          ServiceQuestion question = ServiceQuestion.fromJson(json);
          myQuestions[question.id!] = question;
          myServices[serviceId]!.questionIds.add(question.id!);
        }
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
    // }
  }

  static storeServiceQuestion(ServiceQuestion question) async {
    var response = await RestApi.post(
      storeServiceQuestionsUrl,
      body: question.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        ServiceQuestion question = ServiceQuestion.fromJson(
          response!.data['data'],
        );
        myQuestions[question.id!] = question;
        if (!myServices[question.serviceId]!.questionIds.contains(question.id))
          myServices[question.serviceId]!.questionIds.add(question.id!);
      },
      printResponse: true,
    );
  }

  static deleteServiceQuestion(ServiceQuestion question) async {
    var response = await RestApi.post(
      deleteServiceQuestionsUrl,
      body: {'question_id': question.id},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myQuestions.remove(question.id);
        myServices[question.serviceId]!.questionIds.remove(question.id!);
      },
      printResponse: true,
    );
  }

  static getQuestionOptions(int questionId) async {
    // if(myQuestions[questionId]!.optionIds.length==0){
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      getOptionsUrl,
      body: {'question_id': questionId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        for (var json in response!.data['data']) {
          Option option = Option.fromJson(json);
          myOptions[option.id!] = option;
          myQuestions[questionId]!.optionIds.add(option.id!);
        }
      },
      printResponse: true,
    );

    AppController.isLoading.value = false;
    // }
  }

  static storeQuestionOption(Option option) async {
    var response = await RestApi.post(storeOptionUrl, body: option.toJson());
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        Option option = Option.fromJson(response!.data['data']);
        myOptions[option.id!] = option;
        if (!myQuestions[option.questionId]!.optionIds.contains(option.id))
          myQuestions[option.questionId]!.optionIds.add(option.id!);
      },
      printResponse: true,
    );
  }

  static deleteQuestionOption(Option option) async {
    var response = await RestApi.post(
      deleteOptionUrl,
      body: {'option_id': option.id, 'question_id': option.questionId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        myOptions.remove(option.id);
        myQuestions[option.questionId]!.optionIds.remove(option.id);
      },
      printResponse: true,
    );
  }

  static getOrderDocuments(int orderId) async {
    AppController.isLoading.value = true;
    var response = await RestApi.get(
      getOrderDocuemntsUrl,
      query: {'order_id': orderId},
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        if (MainController.myOrders.containsKey(orderId)) {
          MainController.myOrders[orderId]!.documents = <int, OrderDocument>{};
          for (var json in response!.data['data']) {
            OrderDocument orderDocument = OrderDocument.fromJson(json);
            MainController.myOrders[orderId]!.documents[orderDocument.id!] =
                orderDocument;
          }
        } else {
          MainController.sugestedOrders[orderId]!.documents =
              <int, OrderDocument>{};
          for (var json in response!.data['data']) {
            OrderDocument orderDocument = OrderDocument.fromJson(json);
            MainController.sugestedOrders[orderId]!.documents[orderDocument
                    .id!] =
                orderDocument;
          }
        }
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }
}
