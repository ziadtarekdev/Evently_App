import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/main.dart';
import 'package:event_app/modules/layout/widgets/language_selector.dart';
import 'package:event_app/modules/layout/widgets/button.dart';
import 'package:event_app/modules/layout/widgets/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';

import '../../core/config/gen/assets.gen.dart';
import '../../core/config/services/settings_config.dart';

class LayoutScreenView extends StatelessWidget {
  const LayoutScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingConfig = Provider.of<SettingsConfig>(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Assets.images.eventlylogo.image(width: 140, height: 30),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  settingConfig.currentTheme == ThemeMode.light
                      ? Assets.images.layoutimg.image()
                      : Assets.images.layoutimg.image(color: Colors.white),
                  SizedBox(height: 24),
                  Text(
                    "Personalize Your Experience",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 16),
                  LanguageSelector(),
                  SizedBox(height: 16),
                  ThemeSelector(),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Button(
                text: "Let's start",
                onPressed: _onLetsStartButton,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> _onLetsStartButton() {
    return navigatorKey.currentState!.pushReplacementNamed(
      AppRoutesName.onBoarding,
    );
  }
}
