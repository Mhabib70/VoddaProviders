import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/app-controller.dart';

const double maxItemWidth = 900;
const double paddingSize = 25;
const double borderSize = 1;

const Color whiteColor = Color(0xffFFFFFF);
const Color itemColor1 = Color(0xff212121);
const Color itemColor2 = Color(0xff616161);
const Color itemColor3 = Color(0xff757575);
const Color itemColor4 = Color(0xff9E9E9E);
const Color itemColor5 = Color(0xffEFEFEF);
const Color waitingStateColor = Color(0xffFFB300);
const Color doneStateColor = Color(0xff4CAF50);
const Color doingStateColor = Color(0xff1E88E5);

const Color errorColor = Color(0xffD32F2F);
const Color successColor = Color(0xff4CAF50);
const Color infoColor = Color(0xff0cccd2);
const Color warningColor = Color(0xffFFB300);

final Color overlayColor = Colors.black.withOpacity(0.15);

final List<BoxShadow> shadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    spreadRadius: 0,
    blurRadius: 5,
  ),
];

final bottomGradient = LinearGradient(
  colors: [
    Colors.white.withOpacity(1),
    Colors.white.withOpacity(0.7),
    Colors.white.withOpacity(0),
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

final topGradient = LinearGradient(
  colors: [
    Colors.white.withOpacity(1),
    Colors.white.withOpacity(0.7),
    Colors.white.withOpacity(0.2),
    Colors.white.withOpacity(0),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

Map<int, Color> _primaryMap = {
  50: AppController.primaryColor.withOpacity(0.05),
  100: AppController.primaryColor.withOpacity(0.1),
  200: AppController.primaryColor.withOpacity(0.2),
  300: AppController.primaryColor.withOpacity(0.3),
  400: AppController.primaryColor.withOpacity(0.4),
  500: AppController.primaryColor.withOpacity(0.5),
  600: AppController.primaryColor.withOpacity(0.6),
  700: AppController.primaryColor.withOpacity(0.7),
  800: AppController.primaryColor.withOpacity(0.8),
  900: AppController.primaryColor.withOpacity(0.9),
};

MaterialColor primarySwatch = MaterialColor(
  Colors.blue[600]!.value,
  _primaryMap,
);
