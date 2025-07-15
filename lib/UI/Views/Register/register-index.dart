import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Views/Main/main-index.dart';
import 'package:vodda_providers/UI/Views/Register/register-confirm.dart';
import 'package:vodda_providers/UI/Views/Register/register-form.dart';
import 'package:vodda_providers/UI/Views/Register/register-map.dart';
import 'package:vodda_providers/UI/Views/Register/register-speciality.dart';
import 'package:vodda_providers/UI/Views/Register/register-upload.dart';

class RegisterIndex extends StatelessWidget {
  const RegisterIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Loading(
        getLoadedComponent: () => Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    RegisterController.registerStep.value == 2
                        ? Container()
                        : SafeArea(child: SizedBox(height: 70)),
                    Expanded(
                      child: RegisterController.registerStep.value == 1
                          ? RegisterForm()
                          : RegisterController.registerStep.value == 2
                          ? RegisterMap()
                          : RegisterController.registerStep.value == 3
                          ? RegisterSpeciality()
                          : RegisterController.registerStep.value == 4
                          ? RegisterUpload()
                          : RegisterConfirm(),
                    ),
                    RegisterController.registerStep.value == 2
                        ? Container()
                        : SizedBox(height: paddingSize + 45),
                  ],
                ),

                Positioned(top: 0, child: MainHeader()),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width > maxItemWidth
                        ? maxItemWidth
                        : size.width,
                    padding: EdgeInsets.only(
                      bottom: paddingSize,
                      left: paddingSize,
                      right: paddingSize,
                    ),
                    child: RegisterController.registerStep == 1
                        ? Btn(
                            btnType.primary,
                            text: 'ادامه',
                            onClick: () {
                              RegisterController.changeStep();
                            },
                          )
                        : RegisterController.registerStep == 2 ||
                              RegisterController.registerStep == 3
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Btn(
                                btnType.primary,
                                text: 'ادامه',
                                isHalf: true,
                                onClick: () {
                                  if (RegisterController.registerStep.value ==
                                      2)
                                    RegisterController.findAddress();
                                  else
                                    RegisterController.updateUser();
                                },
                              ),
                              Btn(
                                btnType.secondary,
                                text: 'بازگشت',
                                isHalf: true,
                                onClick: () {
                                  RegisterController.changeStep(isNext: false);
                                },
                              ),
                            ],
                          )
                        : RegisterController.registerStep == 4
                        ? Btn(
                            btnType.primary,
                            text: 'ارسال',
                            onClick: () {
                              RegisterController.storeDocument();
                            },
                          )
                        : Container(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
