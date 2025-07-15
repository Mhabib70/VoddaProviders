import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';

class MessageIndex extends StatelessWidget {
  const MessageIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackHeader(title: 'جزئیات پیام'),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: paddingSize,
                    left: paddingSize,
                    bottom: 15,
                  ),
                  padding: EdgeInsets.only(
                    right: paddingSize,
                    left: paddingSize,
                  ),
                  height: 65,
                  width: maxItemWidth,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Img(
                            messageIcon,
                            width: 30,
                            height: 24,
                            color: AppController.primaryColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'عنوان پیام دوم',
                            style: AppController.fontStyle(
                              fontTypes.heading3,
                              itemColor2,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ' 25 خرداد 1398',
                        style: AppController.fontStyle(
                          fontTypes.heading5,
                          itemColor4,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: maxItemWidth,
                      margin: EdgeInsets.only(
                        right: paddingSize,
                        left: paddingSize,
                      ),
                      child: Text(
                        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
                        style: AppController.fontStyle(
                          fontTypes.text2,
                          itemColor2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(paddingSize),
            child: Btn(
              btnType.primary,
              width: maxItemWidth,
              height: 45,
              fontType: fontTypes.heading3,
              text: 'بازگشت',
              onClick: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
