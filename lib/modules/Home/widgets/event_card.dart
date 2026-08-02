

import 'package:date_format/date_format.dart';
import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';

import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../services/fire_base_services.dart';
import '../../data/category_data.dart';

Widget eventCard(ThemeData theme, CategoryData event) {
  return GestureDetector(
    onTap: () => navigatorKey.currentState!.pushNamed(AppRoutesName.eventDetails,arguments: event),
    child: Container(
      height: 195,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(event.img),
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
              color: LightThemeColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: LightThemeColors.stroke,
              ),
            ),
            child: Text(
              event.selectedDateTime == null
                  ? "No date"
                  : formatDate(
                event.selectedDateTime!,
                [dd, '-', M],
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  event.name,
                  style: theme.textTheme.titleSmall,
                ),
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
      ).paddingSymmetric(
        horizontal: 16,
        vertical: 16,
      ),
    ),
  );
}