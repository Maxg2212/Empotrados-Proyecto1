import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

class DoorControlCard extends StatefulWidget {
  final String doorLabel;
  final bool isOpen;
  final VoidCallback onToggle;

  const DoorControlCard({
    super.key,
    required this.doorLabel,
    required this.isOpen,
    required this.onToggle,
  });

  @override
  State<DoorControlCard> createState() => _DoorControlCardState();
}

class _DoorControlCardState extends State<DoorControlCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Duration animationDuration;

  @override
  void initState() {
    super.initState();

    animationDuration = const Duration(milliseconds: 600);

    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _controller.value = widget.isOpen ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(covariant DoorControlCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isOpen != widget.isOpen) {
      if (widget.isOpen) {
        _controller.duration = animationDuration;
        _controller.forward();
      } else {
        _controller.duration = const Duration(milliseconds: 400);
        _controller.value = 1.0;
        _controller.reverse();
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF7D7F7D).withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: widget.isOpen ? Colors.lightBlueAccent.withOpacity(0.25) : Colors.black26,
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.asset(
                'assets/lottie/door_animation.json',
                controller: _controller,
                height: 170,
                repeat: false,
                onLoaded: (composition) {
                  _controller.duration = animationDuration;
                },
              ),
              const SizedBox(height: 12),
              Text(
                widget.doorLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isOpen ? 'Status: OPEN' : 'Status: CLOSED',
                style: TextStyle(
                  color: widget.isOpen ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF474B4E).withOpacity(0.9),
                  foregroundColor: Colors.white,
                ),
                onPressed: widget.onToggle,
                child: Text(widget.isOpen ? 'Close Door' : 'Open Door'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
