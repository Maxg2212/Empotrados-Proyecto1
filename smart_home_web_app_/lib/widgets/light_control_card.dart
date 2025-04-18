import 'package:flutter/material.dart';
import 'dart:ui';

class LightControlCard extends StatelessWidget {
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
                color: isOn ? Colors.yellow.withOpacity(0.2) : Colors.black26,
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
                lightLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isOn ? 'Status: ON' : 'Status: OFF',
                style: TextStyle(
                  color: isOn ? Colors.greenAccent : Colors.redAccent,
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
                child: Text(isOn ? 'Turn Off' : 'Turn On'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
