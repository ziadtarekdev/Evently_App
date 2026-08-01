import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';

import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../data/category_data_list.dart';
class ListOfEvents extends StatelessWidget {
  final int selectedIndex;

  const ListOfEvents({super.key,required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: StreamBuilder<QuerySnapshot<CategoryData>>(
        stream: FireBaseServices().getRealTime(CategoryDataList.categories[selectedIndex].eventID),
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
              final CategoryData event = events[index];

              return Container(
                height: 195,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(event.img),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration( color: LightThemeColors.background,
                        borderRadius:
                        BorderRadius.circular(8),
                        border: Border.all(
                          color: LightThemeColors.stroke,
                        ),
                      ),
                      child: Text(
                        event.selectedDateTime == null
                            ? "No date"
                            : formatDate(
                          event.selectedDateTime!,
                          [dd, '-', M],
                        ),
                        style: theme
                            .textTheme.titleMedium
                            ?.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.name,
                            style:
                            theme.textTheme.titleSmall,
                          ),
                        ),
                        Assets.icons.favorite.svg(),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
