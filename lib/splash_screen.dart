import 'package:catalift_assignment/constants/app_colors.dart';
import 'package:catalift_assignment/screens/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double height;
  late double width;

  void moveToProductPage() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(
      context,
      NoSwipeCupertinoPageRoute(
        builder: (context) {
          return ProductPage();
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToProductPage();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor(AppColors.blueColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.catalift,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.030),
            LoadingAnimationWidget.stretchedDots(
              color: Colors.white,
              size: height * 0.100,
            ),
          ],
        ),
      ),
    );
  }
}

class NoSwipeCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  NoSwipeCupertinoPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  bool get popGestureEnabled => false; // 🚫 Disable the swipe back gesture
}
