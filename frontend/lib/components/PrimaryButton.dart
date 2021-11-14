import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final TextStyle textStyle;
  final Function() onPressed;

  PrimaryButton({
    required this.text,
    required this.color,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
