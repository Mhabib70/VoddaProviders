import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/notification-controller.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../General/img.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class MainHeader extends StatelessWidget {
  double padding;
  MainHeader({this.padding = paddingSize});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: 70,
        width: size.width,
        padding: EdgeInsets.only(left: this.padding, right: this.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppController.title}',
              style: AppController.fontStyle(fontTypes.heading2, itemColor1),
            ),
            InkWell(
              onTap: () async {
                launchUrlString(AppController.baseUrl);
              },
              child: Img(AppController.logo, width: 40, height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
