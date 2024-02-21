import 'dart:convert';

import 'package:anom_alert/providers/camera_provider.dart';
import 'package:anom_alert/screens/auth/register_error_messages.dart';
import 'package:anom_alert/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

const Map<String, String> header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _reEnteredPassword = "";
  final _client = http.Client();
  final _registerUrl = Uri.parse("$baseUrl/auth/register");
  late SharedPreferences preferences;

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      http.Response response = await _client.post(_registerUrl,
          headers: header,
          body: json.encode({
            "name": _enteredName.trim(),
            "email": _enteredEmail.trim(),
            "password": _enteredPassword.trim()
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json["status"] == "emailId in use") {
          await EasyLoading.showError(json["status"]);
        } else {
          var myToken = json["token"];
          print(json["token"]);
          preferences.setString("token", myToken);
          EasyLoading.showSuccess(json["status"]);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => HomePage(
                    token: myToken,
                  )));
          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage(token: )));
        }
      } else {
        await EasyLoading.showError(
            "Error Code : ${response.statusCode.toString()}");
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }

  void initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
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
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello! Register to get started",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Color(0xFF515D6B)),
                            decoration: const InputDecoration(
                              label: Text("Name"),
                              hintText: "Enter your name",
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1) {
                                return "Name must not be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredName = value!;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Color(0xFF515D6B)),
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Enter your email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter a valid Email ID";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Color(0xFF515D6B)),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text("Password"),
                              hintText: "Enter password",
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 8) {
                                return "Password should be of atleast 8 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Color(0xFF515D6B)),
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text("Confirm Password"),
                              hintText: "Re-Enter password",
                            ),
                            validator: (value) {
                              if (_reEnteredPassword != _enteredPassword) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _reEnteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                registerUser();
                              },
                              child: Text(
                                "Register",
                                style: GoogleFonts.urbanist(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/google-logo.png"),
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Sign Up with Google",
                                    style: GoogleFonts.urbanist(),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
