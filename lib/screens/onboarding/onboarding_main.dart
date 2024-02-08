import 'package:anom_alert/screens/login_or_register.dart';
import 'package:anom_alert/screens/onboarding/onboarding_content.dart';
import 'package:anom_alert/screens/onboarding/swipe_pill.dart';
import 'package:flutter/material.dart';
import 'onboarding_data.dart';

late BuildContext contextLate;

class MainOnboardingScreen extends StatefulWidget {
  const MainOnboardingScreen({super.key});

  @override
  State<MainOnboardingScreen> createState() => _MainOnboardingScreenState();
}

class _MainOnboardingScreenState extends State<MainOnboardingScreen> {
  late PageController _pageController;
  var currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    contextLate = context;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 3,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) => OnboardingContent(
                      image: onboardData[index].image,
                      title: onboardData[index].title,
                      body: onboardData[index].description)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  SwipePill(currentIndex, 0),
                  const SizedBox(
                    width: 8,
                  ),
                  SwipePill(currentIndex, 1),
                  const SizedBox(
                    width: 8,
                  ),
                  SwipePill(currentIndex, 2),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginOrRegisterScreen()));
                      },
                      child: Text(
                        "Skip",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xFF1E1E1E)),
                      )),
                  const Spacer(),
                  SizedBox(
                    height: 36,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFF7F8F9)),
                      onPressed: () {
                        currentIndex != 2
                            ? _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease)
                            : Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginOrRegisterScreen()));
                      },
                      child: currentIndex != 2
                          ? Row(
                              children: [
                                Text(
                                  "Next",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                )
                              ],
                            )
                          : Text(
                              "Continue",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
