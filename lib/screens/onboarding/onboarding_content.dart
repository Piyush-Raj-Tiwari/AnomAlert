import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent(
      {super.key,
      required this.image,
      required this.title,
      required this.body});

  final Widget image;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        image,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(body,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ))
      ],
    );
  }
}
