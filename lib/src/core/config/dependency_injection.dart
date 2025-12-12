// src/core/config/dependency_injection.dart
import 'package:get_it/get_it.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // إذا أردت تسجيل البلوكات

final GetIt getIt = GetIt.I;

class DependencyInjection {
  static Future<void> init() async {
    // ----------------------------------------------------
    //  تسجيل الخدمات هنا
    //  تم حذف أي استدعاء لـ GetIt.I.get<LanguageCubit>() لمنع الخطأ
    //  نحن نسجل Bloc/Cubit فقط إذا كنا سنستخدم BlocProvider.value أو GetIt.I.get
    //  بما أنك تستخدم BlocProvider محليًا في ChatPage، فلا داعي لتسجيل ChatBloc هنا
    // ----------------------------------------------------

    // مثال لتسجيل خدمة (يمكنك إضافة الخدمات الأخرى هنا لاحقاً)
    // getIt.registerLazySingleton<SharedPreferenceService>(() => SharedPreferenceService());

    // تأكد من أن أي كلاس آخر لا يطلب LanguageCubit كـ تبعية
    // إذا كنت تستخدم GetX، فابحث في ملفات الـ bindings أو Controllers أيضًا.
  }
}

// قم بتغيير اسم الملف إلى 'config.dart' إذا كان هذا هو الاسم الذي استخدمته في main.dart