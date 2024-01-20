import 'dart:async';

import 'package:anom_alert/screens/auth/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  const MainPage();
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> _googleSignIn() async {
  await signInWithGoogle();
  const MainPage();
}

class GoogleSignInAuth extends StatelessWidget {
  const GoogleSignInAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: _googleSignIn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/google-logo.png"),
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Login with Google",
              style: GoogleFonts.urbanist(),
            ),
          ],
        ));
  }
}
