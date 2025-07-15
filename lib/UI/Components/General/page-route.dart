import 'package:flutter/cupertino.dart';
import 'package:vodda_providers/UI/Views/User/splash.dart';

class MainPageRoute extends CupertinoPageRoute {
  MainPageRoute() : super(builder: (BuildContext context) => new Splash());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return new FadeTransition(opacity: animation, child: new Splash());
  }
}
