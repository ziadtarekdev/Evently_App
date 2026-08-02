import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:event_app/modules/Home/widgets/list_of_events.dart';
import 'package:event_app/modules/data/category_data_list.dart';
import 'package:flutter/material.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../services/fire_base_services.dart';
import '../../Authentication/widgets/text_field_button.dart';
import '../../data/category_data.dart';
import '../widgets/event_card.dart';

class FavouriteScreenView extends StatefulWidget {
  const FavouriteScreenView({super.key});

  @override
  State<FavouriteScreenView> createState() => _FavouriteScreenViewState();
}

class _FavouriteScreenViewState extends State<FavouriteScreenView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
            Expanded(
              child: StreamBuilder<QuerySnapshot<CategoryData>>(
                stream: FireBaseServices().getFavouriteCollection(!CategoryDataList.categories[index].isFavourite),
                builder: (context, snapshot) {
                  final List<CategoryData> events =
                      snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                      ),
                    );
                  }

                  if (events.isEmpty) {
                    return const Center(
                      child: Text("No events yet"),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: events.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      return  eventCard(theme, events[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
