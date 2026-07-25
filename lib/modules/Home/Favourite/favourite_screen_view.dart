import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:event_app/modules/Home/widgets/list_of_events.dart';
import 'package:flutter/material.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../Authentication/widgets/textfield.dart';

class FavouriteScreenView extends StatelessWidget {
  const FavouriteScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFieldButton(
              text: "Search for events",
              suficon: Assets.icons.search.svg(),
            ).paddingSymmetric(horizontal: 16),
            SizedBox(height: 16),
            ListOfEvents(
              img: Assets.images.birthdayimg.provider(),
              date: "21 Jun",
              subtitle: "Meeting for Updating The Development Method ",
            ),
          ],
        ),
      ),
    );
  }
}
