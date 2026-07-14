import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final settingConfig = Provider.of<SettingsConfig>(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            "Theme",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: settingConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.mainColor
                  : DarkThemeColors.mainText,
            ),
          ),
        ),
        Bounce(
          duration: Duration(milliseconds: 210),
          onPressed: () {
            settingConfig.changeTheme(ThemeMode.light);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: BoxBorder.all(
                width: 0.5,
                color: settingConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.stroke
                    : DarkThemeColors.stroke,
              ),
              borderRadius: BorderRadius.circular(8),
              color: settingConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.mainColor
                  : DarkThemeColors.inputs,
            ),
            child: settingConfig.currentTheme.isLight
                ? Assets.icons.sun.svg()
                : Assets.icons.darkthemesun.svg(),
          ),
        ),
        SizedBox(width: 8),
        Bounce(
          duration: Duration(milliseconds: 210),
          onPressed: () {
            settingConfig.changeTheme(ThemeMode.dark);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: settingConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.stroke
                  : DarkThemeColors.mainColor,
            ),
            child: settingConfig.currentTheme == ThemeMode.light
                ? Assets.icons.moon.svg()
                : Assets.icons.darkthememoon.svg(),
          ),
        ),
      ],
    );
  }
}
