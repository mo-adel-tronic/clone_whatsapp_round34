import 'package:clone_whatsapp_round34/generated/l10n.dart';
import 'package:clone_whatsapp_round34/src/core/routes/names.dart';
import 'package:flutter/material.dart';



 
class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         elevation: 0,
        centerTitle: true,
        title: const Text(
          "Phone Authentication",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
               Navigator.pushNamed(context, RoutesName.fingerPrint);
            },
            child:   Text(
             S.of(context).btn_next ,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Please confirm your OTP Code",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "OTP",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 350),
            ],
          ),
        ),
      ),
    );
  }
}