// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get app_name => 'استنساخ واتساب';

  @override
  String get welcome_title => 'مرحبًا بك في Instant WhatsApp';

  @override
  String get welcome_btn => 'الموافقة والمتابعة';

  @override
  String get policy_read => 'اقرأ ';

  @override
  String get policy_privacy => 'سياسة الخصوصية. ';

  @override
  String get policy_tap => 'اضغط \"الموافقة والمتابعة\" للموافقة على ';

  @override
  String get policy_terms => 'شروط الخدمة.';

  @override
  String get login_title => 'أدخل رقم هاتفك';

  @override
  String get login_subtitle => 'يرجى تأكيد رمز دولتك وإدخال رقم هاتفك';

  @override
  String get login_subtitle_link => 'ما هو رقم هاتفي؟';

  @override
  String get login_field_hint => 'رقم الهاتف';

  @override
  String get login_charges_info => 'قد يتم تطبيق رسوم من قبل شركة الاتصالات';

  @override
  String get otp_page_title => 'أدخل رمز التحقق';

  @override
  String get otp_page_subtitle =>
      'يرجى إدخال رمز التحقق المكون من 6 أرقام المرسل إلى رقم هاتفك.';

  @override
  String get otp_page_resend_msg => 'تم إعادة إرسال رمز التحقق.';

  @override
  String get otp_page_resend_btn => 'إعادة إرسال الرمز';

  @override
  String get otp_confirm_text => 'يرجى تأكيد رمز OTP الخاص بك';

  @override
  String get linked_title => 'الاجهزه المرتبطه';

  @override
  String get linked_desc1 => 'يمكنك ربط الاجهزه الاخري بهذا الحساب.';

  @override
  String get linked_desc2 => 'معرفه المزيد';

  @override
  String get linked_btn => 'ربط جهاز';

  @override
  String get linked_status => 'حاله الجهاز';

  @override
  String get linked_status_text =>
      'اضغط علي احد الاجهزه لتسجيل الخروج من ذلك الجهاز';

  @override
  String get linked_device_name => 'Windows';

  @override
  String get linked_device_active => 'Last active today at 2:28 pm';

  @override
  String get linked_encryption1 => 'رسائلك الشخصيه ';

  @override
  String get linked_encryption2 => 'مشفره تماما بين الطرفين';

  @override
  String get linked_encryption3 => '\n علي جميع الاجهزه';

  @override
  String get btn_next => 'التالي';

  @override
  String get btn_loading => 'جارٍ المعالجة...';

  @override
  String get search_label => 'بحث';

  @override
  String get search_hint => 'ابدأ الكتابة للبحث';

  @override
  String get error_auto_verify =>
      'لم نتمكن من التحقق تلقائيًا من رقم هاتفك. يرجى إدخاله يدويًا.';

  @override
  String get error_verify_failed => 'فشل التحقق. يرجى المحاولة مرة أخرى.';

  @override
  String get error_unknown => 'حدث خطأ غير معروف. يرجى المحاولة مرة أخرى.';

  @override
  String get error_country_code =>
      'رمز الدولة غير صالح. يرجى التحقق والمحاولة مرة أخرى.';

  @override
  String get error_phone_number =>
      'رقم الهاتف غير صالح. يرجى التحقق والمحاولة مرة أخرى.';

  @override
  String get error_phone_empty => 'يرجى إدخال رقم الهاتف.';

  @override
  String get error_otp_send_failed =>
      'فشل في إرسال رمز التحقق. يرجى المحاولة مرة أخرى.';

  @override
  String get error_otp_empty => 'يرجى إدخال رمز التحقق.';
}
