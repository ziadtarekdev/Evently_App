import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/config/routes/app_route.dart';
import 'core/config/services/settings_config.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsConfig(),
      child: const EventApp(),
    ),
  );
}

class EventApp extends StatelessWidget {
   const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsConfig=Provider.of<SettingsConfig>(context);
    return MaterialApp(
      initialRoute: AppRoutesName.initial,
      onGenerateRoute: AppRoute.onGenerateRoute,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: settingsConfig.currentTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
