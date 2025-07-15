import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Items/comment-item.dart';

class CommentsList extends StatelessWidget {
  CommentsList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            BackHeader(title: 'نظرات'),
            Obx(() {
              return Expanded(
                child: UserController.user.value.comments.length > 0
                    ? SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: paddingSize,
                            right: paddingSize,
                          ),
                          child: Column(
                            children: [
                              for (var comment
                                  in UserController.user.value.comments)
                                CommentItem(comment),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Img(
                            commentIcon,
                            width: 130,
                            height: 130,
                            color: AppController.primaryColor,
                          ),
                          SizedBox(height: 40),
                          Text(
                            'موردی یافت نشد !',
                            style: AppController.fontStyle(
                              fontTypes.heading2,
                              itemColor1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'در حال حاظر نظری برای شما ثبت نشده است',
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              itemColor4,
                            ),
                          ),
                        ],
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
