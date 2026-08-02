import 'package:date_format/date_format.dart';
import 'package:event_app/core/config/extensions/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/config/gen/assets.gen.dart';
import '../../../core/config/services/settings_config.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../main.dart';
import '../../../services/fire_base_services.dart';
import '../../Authentication/widgets/text_field_button.dart';
import '../../data/category_data.dart';
import '../../data/category_data_list.dart';
import '../../layout/widgets/button.dart';

class EventEdit extends StatefulWidget {
  const EventEdit({super.key});

  @override
  State<EventEdit> createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {
  int index = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late var category = ModalRoute.of(context)!.settings.arguments as CategoryData;
  bool isInitialized=false;
  @override
  void  didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      category =
      ModalRoute.of(context)!.settings.arguments as CategoryData;
      titleController.text = category.name;
      descriptionController.text = category.description;
      selectedDateTime = category.selectedDateTime;
      selectedTime = category.selectedTime;

      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsConfig = Provider.of<SettingsConfig>(context);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit event", style: theme.textTheme.bodyLarge),
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: LightThemeColors.stroke),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.asset(category.img, fit: BoxFit.cover),
          ),
          SizedBox(height: 16,),
          Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  spacing: 16,
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

                    SizedBox(height: 16,),],
                ).paddingSymmetric(horizontal: 16),

                Column(
                  spacing: 16,
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

                    SizedBox(height: 16,), ],
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
                     Spacer(),
                    TextButton(
                      onPressed: _showDataPicker,
                      child: Text(
                        formatDate(
                          selectedDateTime ?? category.selectedDateTime!,
                          [M, ' ', dd, ',', yyyy],
                        ),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.primaryColor,
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
                        (selectedTime ?? category.selectedTime!).format(context),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),

                Button(
                  text: "Update event",
                  onPressed:() => editEvent(),
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
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );

  }

  Future<void> _showDataPicker() async {
    selectedDateTime = await showDatePicker(
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
  Future<void> editEvent() async {

    final isFormValid = formKey.currentState?.validate() ?? false;

    if (!isFormValid) {
      return;
    }

    if (selectedDateTime == null) {
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


    try {
      await FireBaseServices().updateEvent(
        category.categoryID,
        titleController.text,
        descriptionController.text,
        selectedDateTime,
        selectedTime,
      );
      Fluttertoast.showToast(
          msg: "Edited Successfully",
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
