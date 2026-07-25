import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/gen/assets.gen.dart';
import '../../../../core/config/services/settings_config.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../data/category_data.dart';

class TabOfScreen extends StatelessWidget {
  final CategoryData categoryData;
  const TabOfScreen({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var settingsConfig = Provider.of<SettingsConfig>(context);
    return  Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: settingsConfig.currentTheme == ThemeMode.light
            ? LightThemeColors.inputs
            : DarkThemeColors.inputs,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(
          width: 2,
          color: settingsConfig.currentTheme == ThemeMode.light
              ? LightThemeColors.stroke
              : DarkThemeColors.stroke,
        ),
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(categoryData.icn),
          Text(
            categoryData.name,
            style: theme.textTheme.titleSmall?.copyWith(
              color: LightThemeColors.mainText,
            ),
          ),
        ],
      ),
    );
  }
}
