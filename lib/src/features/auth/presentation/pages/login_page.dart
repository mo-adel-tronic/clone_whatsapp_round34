import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
 import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
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

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = phoneController.text.trim();

     if (selectedCountry == null) {
      setState(() {
        isValid = false;
        errorMessage = null;
      });
      return;
    }

    final result = PhoneValidator.validate(phone);
    setState(() {
      isValid = result;
      errorMessage = result ? null :  S.of(context).error_verify_failed;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      
        elevation: 0,
        centerTitle: true,
        title:   Text(
         S.of(context).login_title,
       
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: isValid
                ? () {
                    Navigator.pushNamed(context, RoutesName.otp);
                  }
                : null,
            child: Text(
               S.of(context).btn_next,
              style: TextStyle(
                fontSize: 16,
                color: isValid ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const Text(
                "Please confirm your country code and enter your phone number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),
               GestureDetector(
                onTap: () {
                  showCountryPickerDialog(
                    context,
                    onSelect: (country) {
                      setState(() {
                        selectedCountry = country;
                      });
                      _validatePhone();
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCountry?.name ?? "Select country",
                        style: const TextStyle(fontSize: 17),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedCountry != null ? "+${selectedCountry!.phoneCode}" : "+__",
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
                            decoration:   InputDecoration(
                              hintText:   S.of(context).login_field_hint, 
                              border: InputBorder.none,
                            ),
                          ),
                          if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.red, fontSize: 13),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}
