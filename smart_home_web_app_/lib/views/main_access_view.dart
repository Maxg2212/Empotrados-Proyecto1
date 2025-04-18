import 'package:flutter/material.dart';
import '../widgets/door_control_card.dart';

class MainAccessView extends StatelessWidget {
  final bool isFrontDoorOpen;
  final bool isBackDoorOpen;
  final VoidCallback onToggleFrontDoor;
  final VoidCallback onToggleBackDoor;

  const MainAccessView({
    super.key,
    required this.isFrontDoorOpen,
    required this.isBackDoorOpen,
    required this.onToggleFrontDoor,
    required this.onToggleBackDoor,
  });

  @override
  Widget build(BuildContext context) {
    // Local mutable state inside the view for visual refresh
    bool localFront = isFrontDoorOpen;
    bool localBack = isBackDoorOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Access'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: StatefulBuilder(
          builder: (context, setInnerState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                DoorControlCard(
                  doorLabel: 'Front Door',
                  isOpen: localFront,
                  onToggle: () {
                    onToggleFrontDoor();         // update in Dashboard
                    localFront = !localFront;    // update locally
                    setInnerState(() {});        // refresh this builder
                  },
                ),

                const SizedBox(height: 24),

                DoorControlCard(
                  doorLabel: 'Back Door',
                  isOpen: localBack,
                  onToggle: () {
                    onToggleBackDoor();
                    localBack = !localBack;
                    setInnerState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
