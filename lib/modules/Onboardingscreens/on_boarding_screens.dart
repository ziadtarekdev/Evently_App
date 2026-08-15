import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/config/services/settings_config.dart';
import '../../core/config/theme/app_colors.dart';
import '../layout/widgets/button.dart';

class OnBoardingScreen extends StatelessWidget {
  final void Function() onPressed;
  final Widget image;
  final String mainText;
  final String subText;
  final String buttonText;
  final PageController controller;
  const OnBoardingScreen({
    super.key,
    required this.image,
    required this.mainText,
    required this.subText,
    required this.buttonText,
    required this.onPressed(),
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    final settingsConfig = Provider.of<SettingsConfig>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          SizedBox(height: 16),
          Align(
            alignment: AlignmentGeometry.center,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.mainColor
                    : DarkThemeColors.mainColor,
                dotColor: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.disable
                    : DarkThemeColors.mainText,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(mainText, style: theme.textTheme.titleLarge),
          SizedBox(height: 8),
          Text(subText, style: theme.textTheme.titleMedium),
          SizedBox(height: 16),
          Spacer(),
          Button(
            text: buttonText,
            onPressed: onPressed,
            style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
