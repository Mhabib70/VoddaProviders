import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Logic/Models/link-menu.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Headers/back-header.dart';

class TextPage extends StatelessWidget {
  LinkMenu linkMenu = LinkMenu();
  TextPage(this.linkMenu);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            BackHeader(title: linkMenu.title!),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(paddingSize),
                  child: Text(
                    '${linkMenu.description ?? ''}',
                    style: AppController.fontStyle(
                      fontTypes.heading4,
                      itemColor3,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
