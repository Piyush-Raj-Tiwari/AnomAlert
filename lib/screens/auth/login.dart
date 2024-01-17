import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

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
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: GoogleFonts.urbanist(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
