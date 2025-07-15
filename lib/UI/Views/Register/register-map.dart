import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:mapir_raster/mapir_raster.dart';

import 'package:flutter/widgets.dart';
// import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';

import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class RegisterMap extends StatelessWidget {
  RegisterMap({Key? key}) : super(key: key);

  MapController controller = MapController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // MapirMap(
        //   apiKey: mapApiKey,
        //   options: MapOptions(
        //     center: UserController.myPosition,
        //     zoom: 16.0,
        //     onPositionChanged: (position, x) {
        //       if (position.center != null)
        //         UserController.myPosition = position.center!;
        //     },
        //   ),
        //   mapController: controller,

        //   layers: [
        //     MarkerLayerOptions(
        //       markers: [
        //         // Marker(
        //         //   width: 50.0,
        //         //   height: 70.0,
        //         //   point: LatLng(35.7324556, 51.4229012),
        //         //   builder: (ctx) => Img(mapIcon,width: 50,height: 70,color: AppController.primaryColor,),
        //         // ),
        //       ],
        //     ),
        //   ],
        // ),
        Positioned(
          top: size.height / 2 - 70,
          left: size.width / 2 - 25,
          child: Img(
            mapIcon,
            width: 50,
            height: 70,
            color: AppController.primaryColor,
          ),
        ),
        Positioned(
          bottom: 100,
          right: paddingSize,
          child: InkWell(
            onTap: () async {
              if (kIsWeb) {
                await UserController.getMyLocation();
                controller.move(UserController.myPosition, 16);
              } else {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.location,
                ].request();
                if (await Permission
                    .locationWhenInUse
                    .serviceStatus
                    .isEnabled) {
                  await UserController.getMyLocation();
                  controller.move(UserController.myPosition, 16);
                }
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: shadow,
              ),
              child: Center(
                child: Icon(Icons.my_location, size: 30, color: itemColor4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
