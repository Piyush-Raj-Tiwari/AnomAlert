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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
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
                        decoration: const InputDecoration(
                          label: Text("Confirm Password"),
                          hintText: "Re-Enter password",
                        ),
                        validator: (value) {
                          if (value != _enteredPassword) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
