import 'package:flutter/material.dart';

class CategoryData {
  String categoryID;
  String eventID;
  String name;
  String description;
  String lightImg;
  String icn;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  bool isFavourite;
  String darkImg;

  CategoryData({
    required this.categoryID,
    required this.eventID,
    required this.name,
    this.description="",
    this.lightImg = "",
    this.icn = "",
    this.selectedTime,
    this.selectedDateTime,
    this.isFavourite = false,
    this.darkImg="",
  });

  Map<String, dynamic> toFirestore() {
    return {
      "categoryID": categoryID,
      "eventID":eventID,
      "categoryName": name,
      "categoryDescription": description,
      "lightCategoryImage": lightImg,
      "darkCategoryImage":darkImg,
      "categoryIcon": icn,
      "isFavourite": isFavourite,
      "categoryDate": selectedDateTime?.millisecondsSinceEpoch,
      "categoryTime": selectedTime == null
          ? null
          : selectedTime!.hour * 60 + selectedTime!.minute,
    };
  }

  factory CategoryData.fromFirestore(Map<String, dynamic> json) {
    final int? dateEpoch = json["categoryDate"] as int?;
    final int? timeMinutes = json["categoryTime"] as int?;

    return CategoryData(
      categoryID: json["categoryID"] as String? ?? "",
      eventID: json["eventID"] as String? ?? "",
      name: json["categoryName"] as String? ?? "",
      description: json["categoryDescription"] as String? ?? "",
      lightImg: json["lightCategoryImage"] as String? ?? "",
      darkImg: json["darkCategoryImage"] as String? ?? "",
      icn: json["categoryIcon"] as String? ?? "",
      isFavourite: json["isFavourite"] as bool? ?? false,
      selectedDateTime: dateEpoch == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(dateEpoch),
      selectedTime: timeMinutes == null
          ? null
          : TimeOfDay(
        hour: timeMinutes ~/ 60,
        minute: timeMinutes % 60,
      ),
    );
  }
}