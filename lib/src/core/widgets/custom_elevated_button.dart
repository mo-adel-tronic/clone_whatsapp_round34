import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.buttonWidth,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    required this.text,
    this.enabled = true,
  });

  final double? buttonWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}