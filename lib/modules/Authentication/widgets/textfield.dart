import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';

class TextFieldButton extends StatelessWidget {
  final String text;
  final Widget icon ;

  final Widget suficon ;
  final bool isPassword;
  const TextFieldButton({super.key, required this.text, required this.icon,this.suficon=const SizedBox(),this.isPassword=false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);


    return
      TextFormField(
        cursorColor: theme.primaryColor,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: icon,
          ),
          prefixIconConstraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24
          ),
          hintText: text,
          hintStyle: theme.textTheme.titleSmall?.copyWith(
            color:settingsConfig.currentTheme==ThemeMode.light
                ? LightThemeColors.secondaryText
                : DarkThemeColors.secondaryText,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width:1,
              color: settingsConfig.currentTheme==ThemeMode.light
                  ? LightThemeColors.stroke
                  : DarkThemeColors.stroke,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width:1,
              color: settingsConfig.currentTheme==ThemeMode.light
                  ? LightThemeColors.stroke
                  : DarkThemeColors.stroke,
            ),
          ),
          disabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width:2,
              color: settingsConfig.currentTheme==ThemeMode.light
                  ? LightThemeColors.stroke
                  : DarkThemeColors.stroke,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width:1,
              color: settingsConfig.currentTheme==ThemeMode.light
                  ? LightThemeColors.stroke
                  : DarkThemeColors.stroke,
            ),
          ),
          suffixIcon:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: suficon,
          ),),
      );
  }
}
