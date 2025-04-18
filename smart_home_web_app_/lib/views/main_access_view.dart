import 'package:flutter/material.dart';
import '../widgets/door_control_card.dart';


// main access view 1
class MainAccessView extends StatefulWidget {
  const MainAccessView({super.key});

  @override
  State<MainAccessView> createState() => _MainAccessViewState();
}

class _MainAccessViewState extends State<MainAccessView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Access'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // FRONT DOOR CONTROL
            const DoorControlCard(doorLabel: 'Front Door'),
          
            const SizedBox(height: 24),

            // BACK DOOR CONTROL
            const DoorControlCard(doorLabel: 'Back Door'),
          ],
        ),
      ),
    );
  }
}
