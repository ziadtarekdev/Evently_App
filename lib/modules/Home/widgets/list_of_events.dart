import 'package:flutter/material.dart';

import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/theme/app_colors.dart';

class ListOfEvents extends StatelessWidget {
  final ImageProvider img;
  final String date;
  final String subtitle;
  const ListOfEvents({
    super.key,
    required this.img,
    required this.date,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: 195,
            width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(image: img)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: LightThemeColors.stroke),
                  ),
                  child: Text(
                    date,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(subtitle, style: theme.textTheme.titleSmall),
                    Spacer(),
                    Assets.icons.favorite.svg(),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemCount: 3,
      ),
    );
  }
}
