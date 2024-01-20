import 'dart:ui';

import 'package:anom_alert/screens/auth/login.dart';
import 'package:anom_alert/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: const AssetImage("assets/images/login-image.png"),
                width: MediaQuery.of(context).size.width,
                height: 0.5 * MediaQuery.of(context).size.height,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)])),
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Anom",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Alert",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const Spacer(),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const RegisterScreen()));
              },
              child: const Text("Register"),
            ),
          ),
          const Spacer(),
          //TextButton(onPressed: () {}, child: Text("Continue as Guest", style: TextStyle(),)),
        ],
      ),
    );
  }
}
