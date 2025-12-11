import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class LinkedDevicesPage extends StatelessWidget {
  const LinkedDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return  Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBarWidget(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImageDescription(),
                  LinkDeviceButton(),
                  DeviceSection(),
                  const SizedBox(height: 35),
                  EncryptionInfo(),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      );
  }
}