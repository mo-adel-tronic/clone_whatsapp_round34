import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  Here we are calling the Dependency Injection
  await DependencyInjection.init();
    await GetItInit.setup();
  //  This is the main app
  runApp(const MyApp());
}
