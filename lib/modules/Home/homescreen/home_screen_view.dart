import 'package:event_app/core/config/gen/assets.gen.dart';
import 'package:event_app/core/config/routes/app_routes_name.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/main.dart';
import 'package:event_app/modules/Home/Favourite/favourite_screen_view.dart';
import 'package:event_app/modules/Home/Profile/profile_screen_view.dart';
import 'package:flutter/material.dart';
import '../MainScreen/main_screen_view.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int currentIndex = 0;
  final List<Widget> _layoutPages = [
    MainScreenView(),
    FavouriteScreenView(),
    ProfileScreenView(),
  ];
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          navigatorKey.currentState!.pushNamed(AppRoutesName.addEvent);
        },
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.unselectedhomeicon.svg(),
            label: "Home",
            activeIcon: Assets.icons.selectedhomeicon.svg(),
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.unselectedfavoriteicon.svg(),
            label: "Favourite",
            activeIcon: Assets.icons.selectedfavoriteicon.svg(),
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.unselectedprofileicon.svg(),
            label: "Profile",
            activeIcon: Assets.icons.selectedprofileicon.svg(),
          ),
        ],
        unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        selectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        unselectedItemColor: LightThemeColors.disable,
        selectedItemColor: theme.primaryColor,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: _layoutPages[currentIndex],
    );
  }
}
