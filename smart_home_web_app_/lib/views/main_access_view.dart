import 'package:flutter/material.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart';

class MainAccessView extends StatelessWidget {
  final bool isFrontDoorOpen;
  final bool isBackDoorOpen;

  const MainAccessView({
    super.key,
    required this.isFrontDoorOpen,
    required this.isBackDoorOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Access'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Front door monitoring
              DoorControlCard(
                doorLabel: 'Front Door',
                isOpen: isFrontDoorOpen,
              ),

              const SizedBox(height: 24),

              // Back door monitoring
              DoorControlCard(
                doorLabel: 'Back Door',
                isOpen: isBackDoorOpen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
