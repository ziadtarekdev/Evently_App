import 'package:flutter/cupertino.dart';

extension PaddingExtension on Widget{
  Widget paddingSymmetric({
    double horizontal=0,double vertical=0,
}) {
      return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal,vertical: vertical),
        child: this,
    );
  }
  }