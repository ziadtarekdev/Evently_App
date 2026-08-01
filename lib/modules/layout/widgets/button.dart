
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';


class Button extends StatelessWidget {
  void Function() onPressed;
  String text;
  TextStyle style;
  Button({
    super.key,
    required this.text,
    required this.onPressed(),
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.primaryColor,
        ),
        child: Center(child: Text(text, style: style)),
      ),
    );
  }
}