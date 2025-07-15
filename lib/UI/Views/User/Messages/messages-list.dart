import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Items/message-item.dart';
import 'package:vodda_providers/UI/Components/Lists/empty-list.dart';
import 'package:vodda_providers/UI/Views/User/Messages/message-index.dart';

class MessagesList extends StatelessWidget {
  int num = 10;
  MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: 'پیام ها'),
          Expanded(
            child: num > 0
                ? SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: paddingSize,
                        left: paddingSize,
                      ),
                      width: size.width,
                      child: Column(
                        children: [
                          for (int x = 0; x < num; x++)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MessageItem(
                                'عنوان پیام',
                                '32 مرداد 1401',
                                'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ ...',
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => MessageIndex(),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmptyList(
                        Img(
                          messageIcon,
                          width: 145,
                          height: 115,
                          color: AppController.primaryColor,
                        ),
                        'موردی یافت نشد !',
                        'هیچ پیامی برای نمایش وجود ندارد ...',
                        btn: Btn(
                          btnType.mini,
                          height: 40,
                          width: 135,
                          text: 'بازگشت',
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
