import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'package:fuel_application/screens/splash/presentation/splash_screen.dart';

void main() async {
  // 1. Preserve native splash screen immediately when user taps app icon
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 2. Perform background initializations during native splash screen display
  await CacheHelper.init();

  // 3. Remove native splash screen as soon as Flutter renders
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}