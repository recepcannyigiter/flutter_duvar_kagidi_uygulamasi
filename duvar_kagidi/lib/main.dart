import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:duvar_kagidi/view/fotograflar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(
    MaterialApp(
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: "assets/splash.png",
          nextScreen: const DuvarKagidi(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 300,
          backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: "MR DUVAR KAĞIDI",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    ),
  );
}
