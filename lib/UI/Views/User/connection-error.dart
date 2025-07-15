import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Img(
            connectionerrorIcon,
            width: 180,
            height: 170,
            color: AppController.primaryColor,
          ),
          SizedBox(height: 50),
          Text(
            'خطا در برقراری ارتباط !',
            style: AppController.fontStyle(
              fontTypes.heading1,
              AppController.primaryColor,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'اتصال به اینترنت برقرار نیست ...',
            style: AppController.fontStyle(fontTypes.heading3, itemColor2),
          ),
          SizedBox(height: 45),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Container(
              height: 45,
              width: 150,
              decoration: BoxDecoration(
                color: AppController.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'تلاش مجدد',
                  style: AppController.fontStyle(
                    fontTypes.heading4,
                    whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
