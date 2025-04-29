import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

class LightControlCard extends StatefulWidget {
  final String lightLabel;
  final bool isOn;
  final VoidCallback onToggle;

  const LightControlCard({
    super.key,
    required this.lightLabel,
    required this.isOn,
    required this.onToggle,
  });

  @override
  State<LightControlCard> createState() => _LightControlCardState();
}

class _LightControlCardState extends State<LightControlCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Duration animationDuration;

  @override
  void initState() {
    super.initState();
    animationDuration = const Duration(milliseconds: 600);
    _controller = AnimationController(vsync: this, duration: animationDuration);

    // If starting ON, show end of turn-on animation
    _controller.value = widget.isOn ? 0.5 : 1.0;
  }

  @override
  void didUpdateWidget(covariant LightControlCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isOn != widget.isOn) {
      if (widget.isOn) {
        // Turn ON (play from 0.0 to 0.5)
        _controller
          ..duration = const Duration(milliseconds: 600)
          ..forward(from: 0.0)
          ..animateTo(0.5);
      } else {
        // Turn OFF (play from 0.5 to 1.0)
        _controller
          ..duration = const Duration(milliseconds: 500)
          ..forward(from: 0.5)
          ..animateTo(1.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        boxShadow: widget.isOn
            ? [
                BoxShadow(
                  color: Colors.yellowAccent.withOpacity(0.4),
                  blurRadius: 40,
                  spreadRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF4C4C4C).withOpacity(0.4), // Darker shade
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bigger Lottie animation
                  SizedBox(
                    height: 170,
                    child: Lottie.asset(
                      'assets/lottie/light_animation__.json',
                      controller: _controller,
                      repeat: false,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.lightLabel,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.isOn ? 'Status: ON' : 'Status: OFF',
                    style: TextStyle(
                      color: widget.isOn
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF474B4E).withOpacity(0.9),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: widget.onToggle,
                    child: Text(widget.isOn ? 'Turn Off' : 'Turn On'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
