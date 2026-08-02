import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';

import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../data/category_data_list.dart';
import 'event_card.dart';
class ListOfEvents extends StatefulWidget {
  final int selectedIndex;

  const ListOfEvents({super.key,required this.selectedIndex});

  @override
  State<ListOfEvents> createState() => _ListOfEventsState();
}

class _ListOfEventsState extends State<ListOfEvents> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: CategoryDataList.categories[widget.selectedIndex].eventID=='all'?
      StreamBuilder <List<CategoryData>>(
        stream: FireBaseServices().getCategoryDataStream(),
        builder: (context, snapshot) {
          final List<CategoryData> events =
              snapshot.data?? [];
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
              return eventCard(theme, events[index]);
            },
          );
        },
      ):StreamBuilder<QuerySnapshot<CategoryData>>(
        stream: FireBaseServices().getRealTime(CategoryDataList.categories[widget.selectedIndex].eventID),
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
              return eventCard(theme, events[index]);
            },
          );
        },
      ),
    );
  }

}