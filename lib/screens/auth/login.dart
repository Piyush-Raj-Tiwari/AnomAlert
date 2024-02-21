import 'dart:convert';

import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/screens/auth/google_sign_in_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:anom_alert/screens/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SharedPreferences preferences;
  final _client = http.Client();
  final _loginUrl = Uri.parse("$baseUrl/auth/login");
  final _registerUrl = Uri.parse("register");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }

  void initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  void logInWithEmail() async {
    http.Response response = await _client.post(_loginUrl,
        headers: header,
        body: json.encode({
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim()
        }));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      //await EasyLoading.showSuccess(json["status"]);
      var myToken = json["token"];
      print(json);
      preferences.setString("token", myToken);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => HomePage(
                token: myToken,
              )));
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }

  // Future signInWithEmail() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim());
  //     SnackBar(content: Text("Successfully signed in as"));
  //   } on FirebaseAuthException catch (e) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             icon: Icon(Icons.error_outline),
  //             iconColor: Colors.redAccent,
  //             title: Text(
  //               "Wrong Password",
  //               style: GoogleFonts.urbanist(color: Colors.redAccent),
  //             ),
  //           );
  //         });
  //   }
  // }
  //
  // Future signInWithGoogle() async {
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  //
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                  child: Column(
                    children: [
                      Text(
                        "Welcome back! Glad to see you again",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextField(
                        style: const TextStyle(color: Color(0xFF515D6B)),
                        controller: _emailController,
                        decoration: const InputDecoration(
                          label: Text("Email"),
                          hintText: "Enter your email",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        style: const TextStyle(color: Color(0xFF515D6B)),
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          label: Text("Password"),
                          hintText: "Enter your Password",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?"))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: logInWithEmail,
                          child: Text(
                            "Login with Email",
                            style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      const GoogleSignInAuth(),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
