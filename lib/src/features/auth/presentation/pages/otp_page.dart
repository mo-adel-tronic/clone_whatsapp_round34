import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/config/config.dart';
import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:clone_whatsapp_round34/src/core/services/auth_service.dart';
import 'package:clone_whatsapp_round34/src/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  const OtpPage({super.key, required this.phone});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _resendCode() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final auth = getIt<AuthService>();
      final res = await auth.signInWithPhone(phone: widget.phone);
      res.fold((failure) {
        if (mounted) {
          if (failure.runtimeType.toString() == 'AuthenticationFailure') {
            setState(() => _error = S.of(context).error_otp_send_failed);
          }
          setState(() => _error = S.of(context).error_unknown);
        }
      }, (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).otp_page_resend_msg)),
          );
        }
      });
    } catch (e) {
      if (mounted) setState(() => _error = S.of(context).error_unknown);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _verifyCode() async {
    final code = _otpController.text.trim();
    if (code.isEmpty) {
      setState(() => _error = S.of(context).error_otp_empty);
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = getIt<AuthService>();
      final res = await auth.verifyOtp(phone: widget.phone, token: code);
      res.fold((failure) {
        if (mounted) setState(() => _error = S.of(context).error_verify_failed);
      }, (_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RoutesName.fingerPrint);
      });
    } catch (e) {
      setState(() => _error = S.of(context).error_unknown);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).otp_page_title)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(18.w),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).otp_page_subtitle,
                        style: theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 20.h),
                      otpTextField(),
                      if (_error != null) errorWidget(),
                      SizedBox(height: 16.h),
                      otpSendBtn(theme, context),
                      SizedBox(height: 8.h),
                      resendBtn(context, theme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row resendBtn(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _isLoading ? null : _resendCode,
          child: Text(S.of(context).otp_page_resend_btn,
              style: TextStyle(color: theme.colorScheme.primary)),
        ),
      ],
    );
  }

  SizedBox otpSendBtn(ThemeData theme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        onPressed: _isLoading ? () {} : _verifyCode,
        text: _isLoading ? S.of(context).btn_loading : S.of(context).btn_next,
        enabled: !_isLoading,
      ),
    );
  }

  Padding errorWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 8.0.h),
      child: Text(_error!, style: const TextStyle(color: Colors.red)),
    );
  }

  TextField otpTextField() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      textAlign: TextAlign.center,
      maxLength: 6,
      decoration: InputDecoration(
          counterText: '',
          hintText: '● ● ● ● ● ●',
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8.r))),
    );
  }
}
