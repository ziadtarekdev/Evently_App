import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/modules/Home/widgets/list_of_events.dart';
import 'package:event_app/modules/data/category_data_list.dart';
import 'package:flutter/material.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../Authentication/widgets/text_field_button.dart';

class FavouriteScreenView extends StatelessWidget {
  const FavouriteScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    int index=0;
    TextEditingController searchController=TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFieldButton(
              text: "Search for events",
              suficon: Assets.icons.search.svg(),
              controller: searchController,
            ).paddingSymmetric(horizontal: 16),
            SizedBox(height: 16),
            ListOfEvents(selectedIndex: index,),
          ],
        ),
      ),
    );
  }
}
