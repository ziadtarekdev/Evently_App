import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/modules/Home/MainScreen/widgets/tab_of_screen.dart';
import 'package:event_app/modules/Home/widgets/list_of_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../data/category_data_list.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final settingsConfig = Provider.of<SettingsConfig>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Welcome Back ✨",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: LightThemeColors.secondaryText,
                  ),
                ).paddingSymmetric(vertical: 16, horizontal: 16),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    settingsConfig.changeTheme(
                      settingsConfig.currentTheme.isLight
                          ? ThemeMode.dark
                          : ThemeMode.light,
                    );
                  },
                  child: settingsConfig.currentTheme == ThemeMode.light
                      ? Assets.icons.sunmainpage.svg()
                      : Assets.icons.moonhomepage.svg(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "EN",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 16),
              ],
            ),
            Text(
              "Dr.BooT",
              style: theme.textTheme.titleLarge,
            ).paddingSymmetric(horizontal: 16),
            SizedBox(height: 24),
            DefaultTabController(
              length: CategoryDataList.categories.length,
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                dividerHeight: 0,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(),
                tabs: List.generate(CategoryDataList.categories.length, (
                  currentIndex,
                ) {
                  final category = CategoryDataList.categories[currentIndex];
                  return TabOfScreen(
                    categoryData: category,
                    isSelected: index == currentIndex,
                  );
                }),
              ),
            ),
            SizedBox(height: 24),
            ListOfEvents(selectedIndex: index),
          ],
        ),
      ),
    );
  }
}
