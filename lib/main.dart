import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/service_locator_config.dart';
import 'features/presentation/ui/splash_page.dart';

Future<void> main() async {
  _configureApplication();
  runApp(MyApp());
}

Future<void> _configureApplication() async {
  await dotenv.load(fileName: ".env");
  configureDependencies();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empresas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
