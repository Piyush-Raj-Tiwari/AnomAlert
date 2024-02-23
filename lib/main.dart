import 'package:anom_alert/api/firebase_api.dart';
import 'package:anom_alert/screens/home_page.dart';
import 'package:anom_alert/screens/onboarding/onboarding_main.dart';
import 'package:anom_alert/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login_or_register.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationToken = await FirebaseMessaging.instance.getToken(vapidKey: "BOIgLBQCEnKa0V99S4gncnr_1mhgnS6aVKwV1AR_bWvSsESA8TR2_hHF4LESLfeirWoz8kt8RovfVPJTq7uxB_E");
  print(notificationToken);
  await FirebaseApi().initNotifications();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  SharedPreferences preferences = await SharedPreferences.getInstance();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message Data: ${message.data}");
    // Handle the message here
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Message opened app: ${message.data}");
    // Handle the message here
  });



  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print("message : $message");
  //   //Navigator.pushReplacement(context, newRoute)
  // });
  //
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
  //   if(message!=null){
  //     print("message2 : $message");
  //   }
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
