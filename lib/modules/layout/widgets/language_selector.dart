import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final settingConfig = Provider.of<SettingsConfig>(context);
    final ThemeData theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            "Language",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: settingConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.mainColor
                  : DarkThemeColors.mainText,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: settingConfig.currentTheme == ThemeMode.light
                ? LightThemeColors.mainColor
                : DarkThemeColors.mainColor,
          ),
          child: Text(
            "English",
            style: theme.textTheme.titleSmall?.copyWith(
              color: LightThemeColors.inputs,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5,color: settingConfig.currentTheme==ThemeMode.light?LightThemeColors.stroke:DarkThemeColors.stroke),
            borderRadius: BorderRadius.circular(8),
            color: settingConfig.currentTheme == ThemeMode.light
                ? LightThemeColors.stroke
                : DarkThemeColors.inputs,
          ),
          child: Text(
            "Arabic",
            style: theme.textTheme.titleSmall?.copyWith(
              color: settingConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.mainColor
                  : DarkThemeColors.mainText,
            ),
          ),
        ),
      ],
    );
  }
}
