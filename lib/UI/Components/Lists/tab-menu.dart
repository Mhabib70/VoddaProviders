import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';
import 'package:vodda_providers/Public/images.dart';
import 'package:vodda_providers/Public/styles.dart';
import 'package:vodda_providers/UI/Components/General/img.dart';
import 'package:get/get.dart';

class TabMenu extends StatefulWidget {
  List<Widget> pages;
  TabMenu({Key? key, this.pages = const []}) : super(key: key);

  @override
  State<TabMenu> createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.pages,
            ),
          ),
          Container(
            height: 75,
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.only(top: 15),
            child: TabBar(
              indicator: CustomTabIndicator(color: AppController.primaryColor),
              labelColor: AppController.primaryColor,
              unselectedLabelColor: itemColor1,
              controller: _tabController,
              onTap: (index) {},
              tabs: [
                Column(
                  children: [
                    Img(
                      menuIcon,
                      width: 22,
                      height: 16,
                      color: _tabController!.index == 0
                          ? AppController.primaryColor
                          : itemColor1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'سفارشات',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Img(
                      bagIcon,
                      width: 22,
                      height: 20,
                      color: _tabController!.index == 1
                          ? AppController.primaryColor
                          : itemColor1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'کارهای من',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Img(
                      receiptIcon,
                      width: 23,
                      height: 18,
                      color: _tabController!.index == 2
                          ? AppController.primaryColor
                          : itemColor1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'کیف پول',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Img(
                      userIcon,
                      width: 18,
                      height: 20,
                      color: _tabController!.index == 3
                          ? AppController.primaryColor
                          : itemColor1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'پروفایل',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  CustomTabIndicator({
    this.radius = 10,
    this.indicatorHeight = 5,
    this.color = Colors.blue,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(this, onChanged, radius, color, indicatorHeight);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 3,
        height: indicatorHeight,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}
