import 'package:flutter/material.dart';
import 'onboarding_main.dart';

class Onboard {
  final Widget image;
  final String description, title;

  Onboard(
      {required this.image, required this.title, required this.description});
}

final List<Onboard> onboardData = [
  Onboard(
      image: Stack(
        children: [
          Image.asset(
            "assets/images/onboarding-bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(contextLate).size.height / 5,
                ),
                Image.asset(
                  "assets/images/onboarding-3.png",
                  height: MediaQuery.of(contextLate).size.height / 4,
                ),
              ],
            ),
          ),
        ],
      ),
      title: "Welcome to AnomAlert",
      description:
          "Connect your cameras effortlessly and experience safety made smarter."),
  Onboard(
      image: Stack(
        children: [
          Image.asset(
            "assets/images/onboarding-bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(contextLate).size.height / 8,
                ),
                Image.asset(
                  "assets/images/onboarding-2.png",
                  height: MediaQuery.of(contextLate).size.height / 3,
                ),
              ],
            ),
          ),
        ],
      ),
      title: "Instant Anomaly Detection",
      description:
          "Our AI-powered system that tracks CCTV footage in real-time to keep you secure."),
  Onboard(
      image: Stack(
        children: [
          Image.asset(
            "assets/images/onboarding-bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(contextLate).size.height / 8,
                ),
                Image.asset(
                  "assets/images/onboarding-1.png",
                  height: MediaQuery.of(contextLate).size.height / 3,
                ),
              ],
            ),
          ),
        ],
      ),
      title: "Notifications on the go",
      description: "Stay in control with AnomAlert's tailored notifications."),
];
