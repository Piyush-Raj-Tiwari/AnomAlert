import 'package:anom_alert/screens/auth/register_error_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _reEnteredPassword = "";

  Future registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: Icon(Icons.error_outline),
              iconColor: Colors.redAccent,
              title: Text(
                SignupWithEmailAndPasswordFailure.code(e.code).message,
                style: GoogleFonts.urbanist(color: Colors.redAccent),
              ),
            );
          });
    }
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
                          const SizedBox(height: 16,),
                          OutlinedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image:
                                    AssetImage("assets/images/google-logo.png"),
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
