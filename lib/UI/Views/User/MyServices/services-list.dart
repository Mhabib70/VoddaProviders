import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Items/service-item.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: Column(
        children: [
          BackHeader(title: 'لیست خدمات من'),
          Expanded(
            child: Loading(
              getLoadedComponent: () {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      right: paddingSize,
                      left: paddingSize,
                    ),
                    width: size.width,
                    child: Obx(() {
                      return Column(
                        children: [
                          for (Service service
                              in MainController.myServices.value.values)
                            ServiceItem(service),
                          SizedBox(height: 100),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
