import 'package:flutter/material.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart';

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
    // Local state for visual refresh
    bool localFront = isFrontDoorOpen;
    bool localBack = isBackDoorOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Access'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: StatefulBuilder(
            builder: (context, setInnerState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  // Front door control
                  DoorControlCard(
                    doorLabel: 'Front Door',
                    isOpen: localFront,
                    onToggle: () {
                      onToggleFrontDoor();      // Update parent state
                      localFront = !localFront; // Update local view
                      setInnerState(() {});     // Re-render
                    },
                  ),

                  const SizedBox(height: 24),

                  // Back door control
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
      ),
    );
  }
}
