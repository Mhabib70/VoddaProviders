import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/Logic/Controllers/register-controller.dart';
import 'package:vodda_providers/Logic/Controllers/user-controller.dart';
import 'package:vodda_providers/Logic/Models/category.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/radio-btn.dart';
import 'package:vodda_providers/UI/Components/General/myDivider.dart';
import 'package:vodda_providers/UI/Components/Selectors/checkbox.dart';
import 'package:vodda_providers/UI/Components/Selectors/radio-group.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

class CategoryItem extends StatefulWidget {
  Category category;
  CategoryItem(this.category, {Key? key}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool showAccordion = false;

  // bool hasService(){
  //   for(var service in widget.category.services!){
  //     if(UserController.user.value.serviceIds.contains(service.id))
  //       return true;
  //   }
  //   return false;
  // }

  @override
  void initState() {
    super.initState();
    // showAccordion=hasService();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showAccordion = !showAccordion;
            });
          },
          child: Container(
            width: maxItemWidth,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.category.title}',
                    style: AppController.fontStyle(
                      fontTypes.heading3,
                      itemColor2,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: showAccordion ? -math.pi / 2 : 0,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: itemColor4,
                  ),
                ),
              ],
            ),
          ),
        ),
        !showAccordion
            ? Container()
            : Column(
                children: [
                  if (!widget.category.hasSub!)
                    for (var service in widget.category.services!)
                      CheckBox(
                        '${service.title}',
                        value: UserController.user.value.serviceIds.contains(
                          service.id,
                        ),
                        onClick: (value) {
                          if (value)
                            UserController.user.value.serviceIds.add(
                              service.id!,
                            );
                          else
                            UserController.user.value.serviceIds.remove(
                              service.id!,
                            );
                        },
                      ),
                  if (widget.category.hasSub!)
                    for (var categoryId in widget.category.categoryIds)
                      CategoryItem(RegisterController.categories[categoryId]!),
                ],
              ),
      ],
    );
  }
}
