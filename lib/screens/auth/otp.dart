import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  Text(
                    "OTP Verification",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Enter the verification code we just sent on your email address",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF838BA1)),
                  )
                                ],
                              ),
                ))
          ],
        ),
      ),
    );
  }
}
