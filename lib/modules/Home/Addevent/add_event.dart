import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:event_app/main.dart';
import 'package:event_app/modules/Home/MainScreen/widgets/tab_of_screen.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';
import '../../../core/config/extensions/padding_extension.dart';
import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../Authentication/widgets/text_field_button.dart';
import '../../data/category_data_list.dart';
import '../../layout/widgets/button.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int index = 0;
  DateTime? selectedDataTime;
  CategoryData? selectedCategory;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final settingsConfig = Provider.of<SettingsConfig>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add event",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: LightThemeColors.mainText,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Bounce(
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
            duration: Duration(milliseconds: 210),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: settingsConfig.currentTheme == ThemeMode.light
                      ? LightThemeColors.stroke
                      : DarkThemeColors.stroke,
                ),
                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.background
                    : DarkThemeColors.inputs,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,

                color: settingsConfig.currentTheme == ThemeMode.light
                    ? LightThemeColors.mainColor
                    : DarkThemeColors.mainText,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(CategoryDataList.categories[index].img),
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
                tabs: List.generate(CategoryDataList.categories.length, (currentIndex) {
                  final category = CategoryDataList.categories[currentIndex];

                  return TabOfScreen(
                      categoryData: category,
                      isSelected: index == currentIndex,
                  );
                  },
              ),
            ),
            ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: LightThemeColors.mainText,
                  ),
                ),
                TextFieldButton(
                  text: "Enter Title",
                  controller: titleController,
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description ",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: LightThemeColors.mainText,
                  ),
                ),
                TextFieldButton(
                  text: "Enter Description",
                  maxlines: 5,
                  controller: descriptionController,
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            Row(
              children: [
                Assets.icons.calendar.svg(),
                SizedBox(width: 8),
                Text(
                  "Event Date",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: LightThemeColors.mainText,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    _showDataPicker();
                  },
                  child: Text(
                    selectedDataTime == null
                        ? "Choose date"
                        : formatDate(
                            DateTime(
                              selectedDataTime!.year,
                              selectedDataTime!.month,
                              selectedDataTime!.day,
                            ),
                            [yyyy, '-', MM, '-', dd],
                          ),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            Row(
              children: [
                Assets.icons.clock.svg(),
                SizedBox(width: 8),
                Text(
                  "Event Time",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: LightThemeColors.mainText,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    _showTimePicker();
                  },
                  child: Text(
                    selectedTime == null
                        ? "Choose time"
                        : selectedTime!.format(context),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            Button(
              text: "Add event",
              onPressed: () async {
                final selectedCategory =
                CategoryDataList.categories[index];

                final CategoryData category = CategoryData(
                  categoryID: "",
                  eventID: CategoryDataList.categories[index].eventID,
                  name: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  selectedDateTime: selectedDataTime,
                  selectedTime: selectedTime,
                  img: selectedCategory.img,
                  icn: selectedCategory.icn,
                );

                await FireBaseServices().createNewEvent(category);

                if (!mounted) return;

                Navigator.pop(context);
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _showDataPicker() async {
    selectedDataTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {});
  }

  Future<void> _showTimePicker() async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {});
  }
}
