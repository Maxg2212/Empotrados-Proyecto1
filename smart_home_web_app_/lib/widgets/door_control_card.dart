import 'package:flutter/material.dart';
import 'dart:ui';

class DoorControlCard extends StatelessWidget {
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
                color: isOpen ? Colors.green.withOpacity(0.2) : Colors.black26,
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
              Text(
                doorLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isOpen ? 'Status: OPEN' : 'Status: CLOSED',
                style: TextStyle(
                  color: isOpen ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF474B4E).withOpacity(0.9),
                  foregroundColor: Colors.white,
                ),
                onPressed: onToggle,
                child: Text(isOpen ? 'Close Door' : 'Open Door'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
