import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Models/addition.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';

class AdditionItem extends StatelessWidget {
  Addition addition = Addition();
  AdditionItem(this.addition, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Img(additionIcon, color: AppController.primaryColor),
              SizedBox(width: 10),
              Text(
                '${addition.description == null
                    ? ''
                    : addition.description!.length > 30
                    ? '${addition.description!.substring(0, 29)}...'
                    : addition.description!}',
                style: AppController.fontStyle(fontTypes.heading4, itemColor4),
              ),
            ],
          ),
          Text(
            '${AppController.priceFormat(addition.amount!)} تومان',
            style: AppController.fontStyle(fontTypes.heading4, itemColor4),
          ),
        ],
      ),
    );
  }
}
