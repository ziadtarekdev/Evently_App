import 'package:date_format/date_format.dart';
import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../services/fire_base_services.dart';
import '../../data/category_data.dart';

/// Displays a single event card with date badge, name, and favourite toggle.
class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.theme, required this.event});

  final ThemeData theme;
  final CategoryData event;

  @override
  Widget build(BuildContext context) {
    final settingsConfig = Provider.of<SettingsConfig>(context);
    return GestureDetector(
      onTap: () => navigatorKey.currentState!.pushNamed(
        AppRoutesName.eventDetails,
        arguments: event,
      ),
      child: Container(
        height: 195,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(
              settingsConfig.currentTheme.isDark
                  ? event.darkImg
                  : event.lightImg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: settingsConfig.currentTheme.isDark
                    ? DarkThemeColors.background
                    : LightThemeColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: settingsConfig.currentTheme.isDark
                      ? DarkThemeColors.stroke
                      : LightThemeColors.stroke,
                ),
              ),
              child: Text(
                event.selectedDateTime == null
                    ? "No date"
                    : formatDate(event.selectedDateTime!, [dd, '-', M]),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(event.name, style: theme.textTheme.titleSmall),
                ),
                GestureDetector(
                  onTap: () async {
                    final newFavouriteValue = !event.isFavourite;

                    await FireBaseServices().updateFavouriteEvent(
                      event.categoryID,
                      newFavouriteValue,
                    );
                  },
                  child: event.isFavourite
                      ? Assets.icons.filledfavourite.svg()
                      : Assets.icons.favorite.svg(),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
