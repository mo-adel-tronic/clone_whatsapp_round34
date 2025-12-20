import 'dart:async';
import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:clone_whatsapp_round34/src/core/theme/theme.dart';
import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:clone_whatsapp_round34/src/features/calls/domain/repositories/call_repository.dart'; // تأكد من المسار الصحيح
import 'package:clone_whatsapp_round34/src/features/calls/presentation/pages/incoming_call_page.dart'; // تأكد من المسار الصحيح
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CallRepository _callRepo = CallRepository();
  StreamSubscription? _callSubscription;
  StreamSubscription? _authSubscription; // 🆕 لمراقبة الدخول والخروج
  bool _isCallPageOpen = false; // 🆕 1. متغير للتحكم

  // مفتاح عالمي للتنقل
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _setupAuthListener(); // 👈 نبدأ مراقبة حالة المستخدم
  }

  void _setupAuthListener() {
    // هذه الدالة تعمل كلما تغيرت حالة المستخدم (سجل دخول أو خروج)
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      
      if (session != null) {
        // ✅ المستخدم سجل دخول: ابدأ الاستماع للمكالمات
        AppLogger.i("User Signed In: Starting Call Listener...");
        _startListeningForCalls();
      } else {
        // ❌ المستخدم سجل خروج: أوقف الاستماع
        AppLogger.e("User Signed Out: Stopping Call Listener...");
        _stopListeningForCalls();
      }
    });
  }

  void _startListeningForCalls() {
    // نتجنب تكرار الاستماع إذا كان يعمل بالفعل
    if (_callSubscription != null) return;

    final myId = Supabase.instance.client.auth.currentUser?.id;
    if (myId == null) return;

    AppLogger.i("🎧 Listening for calls for user: $myId");

    _callSubscription = _callRepo.listenToIncomingCalls().listen((data) {
      AppLogger.i("🔔 Call Stream Update: Received ${data.length} calls");
      
      // 1. الشرط: لو الصفحة مفتوحة، اخرج فوراً
      if (_isCallPageOpen) return;

      if (data.isNotEmpty) {
        final call = data.first;
        AppLogger.i("📞 Incoming call detected from: ${call['caller_name']}");

        // 2. نغلق الباب (نمنع استقبال مكالمات أخرى)
        _isCallPageOpen = true;

        if (navigatorKey.currentState?.mounted ?? false) {
           navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => IncomingCallPage(
                callId: call['id'],
                callerName: call['caller_name'] ?? 'Unknown',
                callerAvatar: call['caller_avatar'],
                channelId: call['channel_id'],
              ),
            ),
          ) // 👈 لاحظ: لم نضع فاصلة منقوطة هنا، بل وضعنا نقطة
          .then((_) {
             // ✅ 3. الحل هنا: عند إغلاق الصفحة (بأي طريقة)، نعيد فتح الباب
             _isCallPageOpen = false;
             AppLogger.i("Call Page Closed. Ready for new calls ✅");
          });
        }
      }
    }, onError: (error) {
      AppLogger.e("🔴 Error listening to calls: $error");
    });
  }

  void _stopListeningForCalls() {
    _callSubscription?.cancel();
    _callSubscription = null;
  }

  @override
  void dispose() {
    _callSubscription?.cancel();
    _authSubscription?.cancel(); // 🆕 لا تنس إلغاء هذا أيضاً
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 914.3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, ch) => DismissKeyboard(
        child: BlocProvider(
          create: (context) => getIt<LanguageCubit>(),
          child: BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) => MaterialApp(
              navigatorKey: navigatorKey, // 👈 مهم جداً
              title: 'WhatsApp Clone',
              // ... باقي الإعدادات كما هي
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.home,
              onGenerateRoute: AppRoute.generate,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
            ),
          ),
        ),
      ),
    );
  }
}