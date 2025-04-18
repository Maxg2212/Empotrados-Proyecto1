import 'package:flutter/material.dart';

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
  
    return Card(
  elevation: 4,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        Text(
          lightLabel,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        
        Text(
          isOn ? 'Status: ON' : 'Status: OFF',
          style: TextStyle(
            color: isOn ? Colors.green : Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        
        ElevatedButton(
          onPressed: onToggle,
          child: Text(isOn ? 'Turn Off' : 'Turn On'),
        ),
      ],
    ),
  ),
);

  }
}
