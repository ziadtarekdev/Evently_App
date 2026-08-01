import 'package:flutter/material.dart';

class CategoryData {
  String categoryID;
  String eventID;
  String name;
  String description;
  String img;
  String icn;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  bool isFavourite;

  CategoryData({
    required this.categoryID,
    required this.eventID,
    required this.name,
    this.description="",
    this.img = "",
    this.icn = "",
    this.selectedTime,
    this.selectedDateTime,
    this.isFavourite = false,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "categoryID": categoryID,
      "eventID":eventID,
      "categoryName": name,
      "categoryDescription": description,
      "categoryImage": img,
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
      img: json["categoryImage"] as String? ?? "",
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