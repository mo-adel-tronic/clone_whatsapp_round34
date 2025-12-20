import 'package:intl/intl.dart';

/// دالة لتنسيق الوقت ليظهر مثل واتساب
/// (مثال: 10:30 PM أو Yesterday أو 20/12/2023)
String formatDate(DateTime? date) {
  if (date == null) return '';

  final now = DateTime.now();
  final localDate = date.toLocal(); // التأكد من التوقيت المحلي

  // حساب الفرق في الأيام
  final difference = now.difference(localDate).inDays;

  if (difference == 0 && localDate.day == now.day) {
    // نفس اليوم: نعرض الساعة فقط
    return DateFormat('hh:mm a').format(localDate);
  } else if (difference == 0 || difference == 1) {
    // أمس
    return 'Yesterday';
  } else {
    // تاريخ قديم
    return DateFormat('dd/MM/yy').format(localDate);
  }
}
