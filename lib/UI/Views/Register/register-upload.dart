import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Selectors/file-picker.dart';

class RegisterUpload extends StatelessWidget {
  const RegisterUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: paddingSize, right: paddingSize),
        child: Column(
          children: [
            SizedBox(height: 20),
            FilePicker(
              onChange: (images) {
                RegisterController.images = images;
              },
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' در این مرحله لازم است مدارک زیر را بارگذاری کنید :',
                  style: AppController.fontStyle(
                    fontTypes.heading4,
                    itemColor1,
                  ),
                ),
                SizedBox(height: 20),

                for (var doc
                    in UserController.user.value.errorDocuments!.length == 0
                        ? RegisterController.documents
                        : RegisterController.documents.where(
                            (element) => UserController
                                .user
                                .value
                                .errorDocuments!
                                .contains(element.group),
                          ))
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Container(
                            height: 5,
                            width: 5,
                            color:
                                UserController
                                        .user
                                        .value
                                        .errorDocuments!
                                        .length ==
                                    0
                                ? itemColor4
                                : errorColor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            '${doc.title}',
                            style: AppController.fontStyle(
                              fontTypes.heading5,
                              UserController
                                          .user
                                          .value
                                          .errorDocuments!
                                          .length ==
                                      0
                                  ? itemColor4
                                  : errorColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
