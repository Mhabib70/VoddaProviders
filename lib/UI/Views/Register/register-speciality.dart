import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/myDivider.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/category-item.dart';
import 'package:vodda_providers/UI/Components/Selectors/checkbox.dart';

class RegisterSpeciality extends StatelessWidget {
  const RegisterSpeciality({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(left: paddingSize,right: paddingSize),
        //   child: Input(lable: 'جستجو در لیست تخصص ها ..',initValue:RegisterController.serviceText,icon1: Icon(Icons.search,size: 25,color: itemColor4),onChange: (text){
        //     RegisterController.serviceText=text;
        //     RegisterController.findService(text);
        //   }),
        // ),
        SizedBox(height: 15),

        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: maxItemWidth,
              margin: EdgeInsets.only(left: paddingSize, right: paddingSize),
              child: Column(
                children: [
                  for (var category
                      in RegisterController.categories.values.where(
                        (element) => element.categoryId == null,
                      ))
                    Column(
                      children: [
                        CategoryItem(category),
                        SizedBox(height: 10),
                        MyDivider(),
                      ],
                    ),
                ],
              ),
              // Obx(
              //   () {
              //     return RegisterController.searchedServices.value.length==0 && RegisterController.serviceText==''?Column(
              //       children: [
              //         for(var service in RegisterController.services.values)
              //           Column(
              //             children: [
              //
              //               SizedBox(height: 10,),
              //               CheckBox('${service.title}',value: UserController.user.value.services.indexWhere((element) => element.id==service.id)!=-1,onClick: (value){
              //                 if(value)
              //                   UserController.user.value.services.add(service);
              //                 else
              //                   UserController.user.value.services.remove(service);
              //               }),
              //               SizedBox(height: 10,),
              //               MyDivider()
              //             ],
              //           ),
              //       ],
              //     ):Column(
              //       children: [
              //         for(var service in RegisterController.searchedServices)
              //           Column(
              //             children: [
              //               CheckBox('${service.title}',value: UserController.user.value.services.indexWhere((element) => element.id==service.id)!=-1,onClick: (value){
              //                 if(value)
              //                   UserController.user.value.services.add(service);
              //                 else
              //                   UserController.user.value.services.remove(service);
              //               }),
              //               MyDivider()
              //             ],
              //           ),
              //       ],
              //     );
              //   }
              // )
            ),
          ),
        ),
      ],
    );
  }
}
