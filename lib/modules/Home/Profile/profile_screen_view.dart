import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  Widget build(BuildContext context) {
    final settingConfig = Provider.of<SettingsConfig>(context);
    ThemeData theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            CircleAvatar(
              backgroundImage: Assets.images.routeimg.provider(),
              radius: 140,
            ),
            SizedBox(height: 10),
            Text(
              "DrBooT",
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),

            Text(
              "drboot.route@gmail.com",
              style: theme.textTheme.titleSmall?.copyWith(
                color: LightThemeColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: settingConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.stroke
                        : DarkThemeColors.stroke,
                  ),
                ),
                child: Row(
                  children: [
                    Text("Dark mode", style: theme.textTheme.titleLarge),
                    Spacer(),
                    DayNightSwitch(
                      duration: Duration(milliseconds: 210),
                      initiallyDark: settingConfig.currentTheme.isDark
                          ? true
                          : false,
                      size: 20,
                      onChange: (dark) => setState(() {
                        settingConfig.changeTheme(
                          dark ? ThemeMode.dark : ThemeMode.light,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: settingConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.stroke
                        : DarkThemeColors.stroke,
                  ),
                ),
                child: Row(
                  children: [
                    Text("Language", style: theme.textTheme.titleLarge),
                    Spacer(),
                    Assets.icons.arrowright.svg(),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: settingConfig.currentTheme == ThemeMode.light
                        ? LightThemeColors.stroke
                        : DarkThemeColors.stroke,
                  ),
                ),
                child: Row(
                  children: [
                    Text("Logout", style: theme.textTheme.titleLarge),
                    Spacer(),
                    Assets.icons.logout.svg(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
