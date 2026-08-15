import 'package:date_format/date_format.dart';
import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/core/config/gen/assets.gen.dart';
import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/config/services/settings_config.dart';
import '../../../main.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as CategoryData;
    final settingsConfig = Provider.of<SettingsConfig>(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Event details",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: settingsConfig.currentTheme.isDark
                ? DarkThemeColors.mainText
                : LightThemeColors.mainText,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Bounce(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
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
        ),
        actions: [
          Bounce(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            duration: Duration(milliseconds: 210),
            child: Container(
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
              child: GestureDetector(
                onTap: () {
                  navigatorKey.currentState!.pushNamed(
                    AppRoutesName.eventEdit,
                    arguments: category,
                  );
                },
                child: Assets.icons.edit.svg().paddingSymmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
              ),
            ),
          ),
          Bounce(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            duration: Duration(milliseconds: 210),
            child: Container(
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
              child: GestureDetector(
                onTap: () {
                  FireBaseServices().deleteEvent(category.categoryID);
                  Fluttertoast.showToast(
                    msg: "Deleted Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  navigatorKey.currentState!.pop();
                },
                child: Assets.icons.delete.svg().paddingSymmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.stroke
                    : DarkThemeColors.stroke,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.asset(
              settingsConfig.currentTheme.isDark
                  ? category.darkImg
                  : category.lightImg,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(category.name, style: theme.textTheme.bodyLarge),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              color: settingsConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.inputs
                  : DarkThemeColors.inputs,
              border: Border.all(
                width: 2,
                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.stroke
                    : DarkThemeColors.stroke,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              spacing: 16,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: settingsConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.inputs
                        : DarkThemeColors.inputs,
                    border: Border.all(
                      width: 2,
                      color: settingsConfig.currentTheme == ThemeMode.light
                          ? LightThemeColors.stroke
                          : DarkThemeColors.stroke,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Assets.icons.calendar.svg(),
                ),
                Column(
                  children: [
                    Text(formatDate(category.selectedDateTime!, [dd, ' ', MM])),
                    Text(
                      category.selectedTime!.format(context),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: LightThemeColors.disable,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text("Description", style: theme.textTheme.titleMedium),

          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: settingsConfig.currentTheme == ThemeMode.light
                  ? LightThemeColors.inputs
                  : DarkThemeColors.inputs,
              border: Border.all(
                width: 2,
                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.stroke
                    : DarkThemeColors.stroke,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              category.description,
              style: theme.textTheme.titleSmall,
            ).paddingSymmetric(horizontal: 16, vertical: 16),
          ),
        ],
      ).paddingSymmetric(vertical: 16, horizontal: 16),
    );
  }
}
