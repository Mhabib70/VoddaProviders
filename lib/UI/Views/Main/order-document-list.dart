import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Models/order-document.dart';
import 'package:vodda_providers/Logic/Models/order.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Buttons/btn.dart';
import 'package:vodda_providers/UI/Components/General/column-scroll.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/document-item.dart';
import 'package:vodda_providers/UI/Components/Popups/bottom-modal.dart';
import 'package:vodda_providers/UI/Components/Popups/loading.dart';
import 'package:vodda_providers/UI/Components/Selectors/file-picker.dart';

class OrderDocumentList extends StatelessWidget {
  Order order;
  OrderDocumentList(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackHeader(title: 'اطلاعات تکمیلی'),
            Expanded(
              child: Loading(
                getLoadedComponent: () {
                  return ColumnScroll(
                    children: [
                      SizedBox(height: paddingSize),
                      if (order.documents != null)
                        for (var doc
                            in order.documents.values.toList().reversed)
                          DocumentItem(doc),
                      SizedBox(height: paddingSize),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
