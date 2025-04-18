import 'package:flutter/material.dart';

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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              doorLabel,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              isOpen ? 'Status: OPEN' : 'Status: CLOSED',
              style: TextStyle(
                color: isOpen ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onToggle,
              child: Text(isOpen ? 'Close Door' : 'Open Door'),
            ),
          ],
        ),
      ),
    );
  }
}
