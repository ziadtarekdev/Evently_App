import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/services/settings_config.dart';
import 'on_boarding_screens.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _controller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: index >= 1
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Bounce(
                  onPressed: onBack,
                  duration: Duration(milliseconds: 210),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: settingsConfig.currentTheme == ThemeMode.light
                            ? LightThemeColors.stroke
                            : DarkThemeColors.stroke,
                      ),
                      color: settingsConfig.currentTheme == ThemeMode.light
                          ? LightThemeColors.background
                          : DarkThemeColors.inputs,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,

                      color: settingsConfig.currentTheme == ThemeMode.light
                          ? LightThemeColors.mainColor
                          : DarkThemeColors.mainText,
                    ),
                  ),
                ),
              )
            : null,
        title: Assets.images.eventlylogo.image(width: 140, height: 30),
        centerTitle: true,
        actions: index < 2
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TextButton(
                    onPressed: () => _controller.animateToPage(
                      2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                    child: Text(
                      "Skip",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: settingsConfig.currentTheme == ThemeMode.light
                            ? LightThemeColors.mainColor
                            : DarkThemeColors.mainText,
                      ),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      index = value;
                      setState(() {});
                    },
                    controller: _controller,
                    children: [
                      OnBoardingScreen(
                        controller: _controller,
                        image: Assets.images.imgfirstonboarding.image(
                          color: settingsConfig.currentTheme == ThemeMode.light
                              ? LightThemeColors.mainColor
                              : Colors.white,
                        ),
                        buttonText: "Next",
                        mainText: "Find Events That Inspire You",
                        subText:
                            "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
                        onPressed: onPressed,
                      ),
                      OnBoardingScreen(
                        controller: _controller,

                        image: Assets.images.secondonboardingscreen.image(
                          color: settingsConfig.currentTheme == ThemeMode.light
                              ? LightThemeColors.mainColor
                              : Colors.white,
                        ),
                        buttonText: "Next",
                        mainText: "Effortless Event Planning",
                        subText:
                            "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
                        onPressed: onPressed,
                      ),
                      OnBoardingScreen(
                        controller: _controller,

                        image: Assets.images.thirdonboardingscreen.image(
                          color: settingsConfig.currentTheme == ThemeMode.light
                              ? LightThemeColors.mainColor
                              : Colors.white,
                        ),
                        buttonText: "Get Started",
                        mainText: "Connect with Friends & Share Moments",
                        subText:
                            "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",

                        onPressed:() {
                          navigatorKey.currentState!.pushReplacementNamed(AppRoutesName.login);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),

                SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    if (index < 2) {
      _controller.nextPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  void onBack() {
    _controller.animateToPage(
      index - 1,
      duration: Duration(milliseconds: 210),
      curve: Curves.bounceInOut,
    );
  }

  PageController get controller => _controller;
}
