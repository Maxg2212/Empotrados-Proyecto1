import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background animation
        SizedBox.expand(
          child: Lottie.asset(
            'assets/lottie/background.json',
            fit: BoxFit.cover,
            repeat: true,
          ),
        ),
        // Foreground content
        child,
      ],
    );
  }
}
