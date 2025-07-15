import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Helpers/api-methods.dart';
import 'package:vodda_providers/Logic/Models/category.dart';
import 'package:vodda_providers/Logic/Models/city.dart';
import 'package:vodda_providers/Logic/Models/document.dart';
import 'package:vodda_providers/Logic/Models/province.dart';
import 'package:vodda_providers/Logic/Models/service.dart';
import 'package:vodda_providers/Public/api-urls.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:image/image.dart' as IMG;
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/snackbar.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class RegisterController extends GetxController {
  static Map<int, Province> provinces = <int, Province>{};

  static RxList<City> cities = <City>[].obs;

  static Map<int, Service> services = <int, Service>{};
  static String serviceText = '';
  static RxList<Service> searchedServices = <Service>[].obs;

  static List<Document> documents = <Document>[];

  static RxInt registerStep = 1.obs;

  static List images = [];

  static Map<int, Category> categories = <int, Category>{};

  static getCategories() async {
    var response = await RestApi.get(categoryListUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        categories = <int, Category>{};
        for (var json in response!.data['data']) {
          Category category = Category.fromJson(json);
          categories[category.id!] = category;
        }
        for (var category in categories.values) {
          if (categories.keys.contains(category.categoryId))
            categories[category.categoryId]!.categoryIds.add(category.id!);
        }
      },
    );
  }

  static getProvinces() async {
    var response = await RestApi.get(provincesUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        provinces = <int, Province>{};
        for (var json in response!.data['data']) {
          Province province = Province.fromJson(json);
          provinces[province.id!] = province;
        }
        if (UserController.user.value.provinceId != null) {
          cities.value =
              provinces[UserController.user.value.provinceId]!.cities;
        }
      },
    );
  }

  static getServices() async {
    var response = await RestApi.get(serviceListUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        services = <int, Service>{};
        for (var json in response!.data['data']) {
          Service service = Service.fromJson(json);
          services[service.id!] = service;
        }
      },
    );
  }

  static findService(String text) {
    searchedServices.value = [];
    if (text != '')
      for (var service in services.values) {
        if (service.title!.contains(text)) searchedServices.value.add(service);
      }
  }

  static getInfoDocument() async {
    var response = await RestApi.get(infoDocumentUrl);
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        documents = [];
        for (var json in response!.data['data']['document_info']) {
          Document document = Document.fromJson(json);
          // for(var id in response.data['data']['error_document'])
          //   if(id==document.group)
          //     document.hasError=true;

          documents.add(document);
        }
      },
    );
  }

  static changeStep({bool isNext = true}) {
    if (UserController.user.value.fname == null ||
        UserController.user.value.lname == null ||
        UserController.user.value.fatherName == null ||
        UserController.user.value.nationalCode == null ||
        UserController.user.value.numberCard == null ||
        UserController.user.value.tell == null ||
        UserController.user.value.degree == null ||
        UserController.user.value.sex == null ||
        UserController.user.value.married == null ||
        UserController.user.value.cv == null) {
      showSnackbar(
        snackTypes.error,
        'لطفا همه ی اطلاعات خواسته شده را پر کنید',
      );
      return;
    }

    isNext ? registerStep.value++ : registerStep.value--;
  }

  static findAddress() async {
    AppController.isLoading.value = true;
    UserController.user.value.lat = UserController.myPosition.latitude
        .toString();
    UserController.user.value.long = UserController.myPosition.longitude
        .toString();
    var response = await RestApi.post(
      findAddressUrl,
      body: {
        'lat': UserController.myPosition.latitude,
        'long': UserController.myPosition.longitude,
      },
    );
    await RestApi.responseHandler(
      response: response,
      successCallback: () {
        UserController.user.value.provinceId =
            response!.data['data']['province'];
        cities.value = provinces[UserController.user.value.provinceId]!.cities;
        UserController.user.value.cityId = response.data['data']['city'];
        UserController.user.value.place = response.data['data']['address'];
      },
    );
    showBottomModal(
      Get.context!,
      500,
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'افزودن آدرس',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                  ),
                  SizedBox(height: 30),

                  SelectBox(
                    text: 'انتخاب استان',
                    onSelect: (value) {
                      UserController.user.value.cityId = null;
                      cities.value = [];
                      UserController.user.value.provinceId = value;
                      cities.value = provinces[value]!.cities;
                    },
                    options: {
                      for (var provinceID in provinces.keys)
                        provinces[provinceID]!.name: provinceID,
                    },
                    icon: Img(locationIcon),
                    value: UserController.user.value.provinceId,
                  ),
                  SizedBox(height: 15),
                  Obx(() {
                    return SelectBox(
                      text: 'انتخاب شهر',
                      onSelect: (value) {
                        UserController.user.value.cityId = value;
                      },
                      options:
                          cities.value.length > 0 &&
                              UserController.user.value.provinceId != null
                          ? {for (var city in cities.value) city.name: city.id}
                          : <dynamic, dynamic>{},
                      icon: Img(cityIcon),
                      value: UserController.user.value.cityId,
                    );
                  }),
                  SizedBox(height: 15),
                  Input(
                    lable: 'خیابان / کوچه / پلاک ...',
                    initValue: UserController.user.value.place,
                    onChange: (text) {
                      UserController.user.value.place = text;
                    },
                    icon1: Container(
                      child: Icon(
                        Icons.my_location,
                        size: 20,
                        color: itemColor4,
                      ),
                      width: 50,
                      height: 250,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 5),
                    ),
                    lines: 10,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: paddingSize),
            child: Btn(
              btnType.primary,
              text: 'تایید آدرس',
              onClick: () {
                Navigator.pop(Get.context!);
                changeStep();
              },
            ),
          ),
        ],
      ),
    );

    AppController.isLoading.value = false;
  }

  static updateUser() async {
    AppController.isLoading.value = true;
    var response = await RestApi.post(
      updateUserUrl,
      body: UserController.user.value.toJson(),
    );
    RestApi.responseHandler(
      response: response,
      successCallback: () {
        changeStep();
      },
      printResponse: true,
    );
    AppController.isLoading.value = false;
  }

  static storeDocument() async {
    AppController.isLoading.value = true;
    for (var image in images) {
      await RestApi.post(
        storeDocumentUrl,
        body: {'file': base64.encode(image)},
      );
    }
    changeStep();
    AppController.isLoading.value = false;
  }
}
