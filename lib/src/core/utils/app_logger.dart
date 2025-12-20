import 'package:logger/logger.dart';

class AppLogger {
  // 1. إعداد الـ Logger مع تنسيق جميل (PrettyPrinter)
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // عدد الطرق التي تظهر في الـ StackTrace (0 لتقليل الزحمة)
      errorMethodCount: 5, // عدد الطرق عند حدوث خطأ
      lineLength: 80, // عرض السطر
      colors: true, // تفعيل الألوان
      printEmojis: true, // تفعيل الإيموجي
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // وقت حدوث اللوج
    ),
  );

  // 2. دوال مساعدة لسهولة الاستدعاء
  
  // للمعلومات العامة (لون أزرق/أبيض)
  static void i(String message) {
    _logger.i(message);
  }

  // للبيانات أثناء التطوير (لون رمادي/أخضر) - Debug
  static void d(String message) {
    _logger.d(message);
  }

  // للتحذيرات (لون برتقالي) - Warning
  static void w(String message) {
    _logger.w(message);
  }

  // للأخطاء الكارثية (لون أحمر) - Error
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
  
  // لتتبع الأخطاء القاتلة (لون بنفسجي) - Fatal
  static void f(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}