import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/services/settings_config.dart';
import '../layout/widgets/button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsConfig = Provider.of<SettingsConfig>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password", style: theme.textTheme.bodyLarge),
        centerTitle: true,
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Bounce(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            duration: Duration(milliseconds: 210),
            child: Container(
              decoration: BoxDecoration(
                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.inputs
                    : DarkThemeColors.inputs,
                borderRadius: BorderRadius.circular(14),
                border: BoxBorder.all(
                  width: 3,
                  color: settingsConfig.currentTheme == ThemeMode.light
                      ? LightThemeColors.stroke
                      : DarkThemeColors.stroke,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.arrowLeft.svg(
                  colorFilter: ColorFilter.mode(
                    settingsConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.mainColor
                        : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Assets.images.forgetpassscreen.image(
              color: settingsConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.mainColor
                  : DarkThemeColors.mainText,
            ),
            SizedBox(height: 40),
            Button(
              text: "Reset password",
              onPressed: () {
                navigatorKey.currentState!.pop();
              },
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
