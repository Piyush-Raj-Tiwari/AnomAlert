import 'package:flutter/material.dart';

class SwipePill extends StatelessWidget {
  const SwipePill(this.currentIndex, this.pillNum, {super.key});

  final int currentIndex;
  final int pillNum;

  @override
  Widget build(BuildContext context) {
    final displayColor = currentIndex == pillNum
        ? const Color(0xFF272727)
        : const Color(0xFF272727).withOpacity(0.15);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: displayColor),
    );
  }
}
