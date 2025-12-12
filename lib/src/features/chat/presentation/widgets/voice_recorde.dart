import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoiceRecordOverlay extends StatelessWidget {
  const VoiceRecordOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100.h,
      left: 24.w,
      right: 24.w,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.delete, color: Colors.red),
            Text("Recording...", style: TextStyle(color: Colors.white)),
            Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ],
        ),
      ),
    );
  }
}