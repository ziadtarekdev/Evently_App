import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:event_app/main.dart';
import 'package:event_app/modules/Home/MainScreen/widgets/tab_of_screen.dart';
import 'package:event_app/modules/data/category_data.dart';
import 'package:event_app/services/fire_base_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  int index = 1;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                    index = value+1;
                  });
                },
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                dividerHeight: 0,
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(),
                tabs: List.generate(CategoryDataList.categories.length-1, (currentIndex) {
                  final category = CategoryDataList.categories[currentIndex+1];
                  return TabOfScreen(
                      categoryData: category,
                      isSelected: index == currentIndex+1,
                  );
                  },
              ),
            ),
            ),
        Form(
          key: formKey,
          child: Column(
            children: [
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter event title";
                      }

                      if (value.trim().length < 3) {
                        return "Title must be at least 3 characters";
                      }

                      return null;
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: LightThemeColors.mainText,
                    ),
                  ),
                  TextFieldButton(
                    text: "Enter Description",
                    maxlines: 5,
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter event description";
                      }

                      if (value.trim().length < 10) {
                        return "Description must be at least 10 characters";
                      }

                      return null;
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              Row(
                children: [
                  Assets.icons.calendar.svg(),
                  const SizedBox(width: 8),
                  Text(
                    "Event Date",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: LightThemeColors.mainText,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _showDataPicker,
                    child: Text(
                      selectedDataTime == null
                          ? "Choose date"
                          : formatDate(
                        selectedDataTime!,
                        [M, ' ', dd, ',', yyyy],
                      ),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: selectedDataTime == null
                            ? Colors.red
                            : theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: selectedDataTime == null
                            ? Colors.red
                            : theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              Row(
                children: [
                  Assets.icons.clock.svg(),
                  const SizedBox(width: 8),
                  Text(
                    "Event Time",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: LightThemeColors.mainText,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _showTimePicker,
                    child: Text(
                      selectedTime == null
                          ? "Choose time"
                          : selectedTime!.format(context),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color:
                        selectedTime == null ? Colors.red : theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor:
                        selectedTime == null ? Colors.red : theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),

              Button(
                text: "Add event",
                onPressed: addEvent,
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
  Future<void> addEvent() async {

    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    if (selectedDataTime == null) {
      Fluttertoast.showToast(
          msg: "Please Enter valid date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    if (selectedTime == null) {
      Fluttertoast.showToast(
          msg: "Please choose event time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    final selectedCategory = CategoryDataList.categories[index];

    final CategoryData category = CategoryData(
      categoryID: "",
      eventID: selectedCategory.eventID,
      name: titleController.text.trim(),
      description: descriptionController.text.trim(),
      selectedDateTime: selectedDataTime,
      selectedTime: selectedTime,
      img: selectedCategory.img,
      icn: selectedCategory.icn,
    );

    try {
      await FireBaseServices().createNewEvent(category);
      Fluttertoast.showToast(
          msg: "Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      if (!mounted) return;

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add event: $error"),
        ),
      );
    }
  }
}
