import 'package:Goal/src/config/app_route.dart';
import 'package:Goal/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

 @override
void initState() {
  super.initState();

  Future.delayed(Duration(seconds: 4), () {
    Navigator.of(context).pushReplacementNamed(Routes.soccerLayout);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkgrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/goal.png',
              height: 200,
              width: 200,
            ),
             const Text(
                'Welcome to R2',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

          ],
        ),
      ),
    );
  }

}
