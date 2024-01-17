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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      SnackBar(content: Text("Successfully signed in as"));
    } on FirebaseAuthException catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: const Text("Incorrect email ID or password"),);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                          style: Theme
                              .of(context)
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
                            onPressed: signIn,
                            child: Text(
                              "Login with Email",
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
                                Text(
                                  "Login with",
                                  style: GoogleFonts.urbanist(),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Image(
                                  image:
                                  AssetImage("assets/images/google-logo.png"),
                                  height: 24,
                                  width: 24,
                                )
                              ],
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
