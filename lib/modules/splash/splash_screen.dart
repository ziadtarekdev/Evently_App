import 'dart:async';

import 'package:event_app/main.dart';
import 'package:flutter/material.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/routes/app_routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      navigatorKey.currentState!.pushReplacementNamed(AppRoutesName.layout);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Assets.images.eventlylogo.image(width: 400)),
    );
  }
}
