import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/config/config.dart';
import 'package:clone_whatsapp_round34/src/core/services/auth_service.dart';
import 'package:clone_whatsapp_round34/src/core/widgets/custom_elevated_button.dart';
import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:clone_whatsapp_round34/src/core/services/phone/phone_number_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  bool isValid = false;
  Country? selectedCountry;
  String? errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validatePhone);
    final auth = getIt<AuthService>();
    final currentUser = auth.currentUser;
    //TODO: Use currentUser info if needed and implement auto-login
    print('Current user at login page: ${currentUser}');
  }

  void _validatePhone() {
    final phone = phoneController.text.trim();

    if (selectedCountry == null) {
      setState(() {
        isValid = false;
        errorMessage = S.of(context).error_country_code;
      });
      return;
    }

    if (phone.isEmpty) {
      setState(() {
        isValid = false;
        errorMessage = S.of(context).error_phone_empty;
      });
      return;
    }

    final phoneService = getIt<PhoneNumberService>();
    final String fullPhone = '+${selectedCountry!.phoneCode}$phone';
    final result = phoneService.isValid(fullPhone, selectedCountry!.countryCode);
    setState(() {
      isValid = result;
      errorMessage = result ? null : S.of(context).error_verify_failed;
    });
  }

  Future<void> _sendVerification() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });
    final countryCode = selectedCountry?.phoneCode ?? '';
    final phone = phoneController.text.trim();

    if (countryCode.isEmpty) {
      setState(() {
        errorMessage = S.of(context).error_country_code;
        _isLoading = false;
      });
      return;
    }

    try {
      // final phoneService = getIt<PhoneNumberService>();
      // final formatted = phoneService.toE164('+$countryCode$phone');
      final auth = getIt<AuthService>();
      //TODO: Use formatted phone number when using a real phone auth service
      // 1123456789, 1023456789 = 123456 is the test number for Supabase
      final res = await auth.signInWithPhone(phone: phone); // Temporary for Supabase testing
      res.fold((failure) {
        if (mounted) {
          if (failure.runtimeType.toString() == 'AuthenticationFailure') {
            setState(() {
              errorMessage = S.of(context).error_verify_failed;
              _isLoading = false;
            });
          } else {
            setState(() {
              errorMessage = S.of(context).error_unknown;
              _isLoading = false;
            });
          }
        }
      }, (_) {
        if (!mounted) return;
        Navigator.pushNamed(context, RoutesName.otp, arguments: {'phone': phone});
      });
      return;
    } catch (e) {
      setState(() {
        errorMessage = S.of(context).error_phone_number;
        _isLoading = false;
      });
      return;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }


  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () async{
          if (!_isLoading && isValid) {
            _sendVerification();
          }
        },
        text: S.of(context).btn_next,
        buttonWidth: 200.w,
      ),
      appBar: AppBar(title: Text(S.of(context).login_title)),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(18.w),
          child: Column(
            children: [
              _loginExplainTxt(context),
              SizedBox(height: 20.h),
              _loginCountryField(context),
              SizedBox(height: 8.h),
              _loginPhoneField(context),
              SizedBox(height: 300.h),
            ],
          ),
        ),
      ),
    );
  }

  Container _loginPhoneField(BuildContext context) {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Text(
                    selectedCountry != null
                        ? "+${selectedCountry!.phoneCode}"
                        : "+__",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(15),
                          ],
                          decoration: InputDecoration(
                            hintText: S.of(context).login_field_hint,
                            border: InputBorder.none,
                          ),
                        ),
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }

  GestureDetector _loginCountryField(BuildContext context) {
    return GestureDetector(
              onTap: () {
                showCountryPickerDialog(
                  context,
                  onSelect: (country) {
                    setState(() {
                      selectedCountry = country;
                    });
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCountry?.name ?? "Select country",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey),
                  ],
                ),
              ),
            );
  }

  Padding _loginExplainTxt(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${S.of(context).login_subtitle}. ',
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: S.of(context).login_subtitle_link,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
