import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/modules/Home/MainScreen/widgets/tab_of_screen.dart';
import 'package:event_app/modules/Home/widgets/list_of_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../data/category_data_list.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryData = CategoryDataList.categories[0];
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
                settingsConfig.currentTheme == ThemeMode.light
                    ? Assets.icons.sunmainpage.svg()
                    : Assets.icons.moonhomepage.svg(),
                SizedBox(width: 8),
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
                ),
              ],
            ),
            Text(
              "Dr.BooT",
              style: theme.textTheme.titleLarge,
            ).paddingSymmetric(horizontal: 16),
            SizedBox(height: 24),
            DefaultTabController(
              length: CategoryDataList.categories.length ,
              child: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                dividerHeight: 0,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(),
                tabs: CategoryDataList.categories
                    .map((category) => TabOfScreen(categoryData: category))
                    .toList(),
              ),
            ),
            SizedBox(height: 24),
            ListOfEvents(
              img: Assets.images.birthdayimg.provider(),
              date: "21 Jun",
              subtitle: "This is a Birthday Party ",
            ),
          ],
        ),
      ),
    );
  }
}
