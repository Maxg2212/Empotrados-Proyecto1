import 'package:flutter/material.dart';

//door control widget 

class DoorControlCard extends StatefulWidget {
  final String doorLabel;

  const DoorControlCard({
    super.key,
    required this.doorLabel,
  });

  @override
  State<DoorControlCard> createState() => _DoorControlCardState();
}

class _DoorControlCardState extends State<DoorControlCard> {
  bool _isOpen = false;

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
              widget.doorLabel,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _isOpen ? 'Status: OPEN' : 'Status: CLOSED',
              style: TextStyle(
                color: _isOpen ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOpen = !_isOpen;
                });
              },
              child: Text(_isOpen ? 'Close Door' : 'Open Door'),
            ),
          ],
        ),
      ),
    );
  }
}
