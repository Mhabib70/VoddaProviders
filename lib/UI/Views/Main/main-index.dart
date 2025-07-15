import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/notification-controller.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/Headers/main-header.dart';
import 'package:vodda_providers/UI/Components/Inputs/input.dart';
import 'package:vodda_providers/UI/Components/Items/order-item.dart';
import 'package:vodda_providers/UI/Components/Lists/tab-menu.dart';
import 'package:vodda_providers/UI/Views/Main/my-works.dart';
import 'package:vodda_providers/UI/Views/Main/payments-list.dart';
import 'package:vodda_providers/UI/Views/Main/profile.dart';
import 'package:vodda_providers/UI/Views/Main/works-list.dart';

class MainIndex extends StatelessWidget {
  const MainIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Container(
          alignment: Alignment.center,
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              MainHeader(),
              Expanded(
                child: TabMenu(
                  pages: [WorksList(), MyWorks(), PaymentsList(), Profile()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
