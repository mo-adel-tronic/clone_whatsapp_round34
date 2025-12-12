import 'package:flutter/material.dart';

class FingerPrintPage extends StatelessWidget {
  const FingerPrintPage({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
       body: SafeArea(
        child: Center(
         
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Icon(
                  Icons.lock_outline,
                  color: Colors.teal[700],
                  size: 36,
                ),
                const SizedBox(height: 12),
                const Text(
                  'WhatsApp Locked',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 60),

                 Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Icon(
                    Icons.fingerprint,
                    size: 96,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 18),
                const Text(
                  'Fingerprint Sensor',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}