import 'package:anom_alert/firebase_options.dart';
import 'package:anom_alert/models/camera.dart';
import 'package:anom_alert/screens/auth/main_page.dart';
import 'package:anom_alert/screens/auth/otp.dart';
import 'package:anom_alert/screens/camera_detail.dart';
import 'package:anom_alert/screens/home_page.dart';
import 'package:anom_alert/screens/onboarding/onboarding_main.dart';
import 'package:anom_alert/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'screens/onboarding/onboarding_content.dart';

import 'screens/login_or_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    child: MyApp(
      token: preferences.getString("token"),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});

  final token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(token);
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //body: CameraDetailsScreen(Camera(name: "name", rtspUrl: "rtspUrl")),

        body: token != null
            ? (JwtDecoder.isExpired(token)
                ? const LoginOrRegisterScreen()
                : HomePage(token: token))
            : const MainOnboardingScreen(),
      ),
      theme: AppTheme.theme,
    );
  }
}
