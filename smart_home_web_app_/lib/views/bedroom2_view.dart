import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/door_control_card.dart';

class Bedroom2View extends StatelessWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;

  final bool isBedroom2DoorOpen;
  final VoidCallback onToggleBedroom2Door;



  const Bedroom2View({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
    required this.isBedroom2DoorOpen,
    required this.onToggleBedroom2Door
  });

  @override
  Widget build(BuildContext context) {
    // Local copy of the state so it can update the UI immediately
    bool localIsOn = isLightOn;
    bool localBedroom2Door = isBedroom2DoorOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bedroom 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: StatefulBuilder(
          builder: (context, setInnerState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                LightControlCard(
                  lightLabel: 'Bedroom Light',
                  isOn: localIsOn,
                  onToggle: () {
                    onToggleLight(); // updates global state in DashboardView
                    localIsOn = !localIsOn; // updates this screen instantly
                    setInnerState(() {});   // triggers rebuild
                  },
                ),

                DoorControlCard(
                  doorLabel: 'Bedroom Door',
                  isOpen: localBedroom2Door,
                  onToggle: () {
                    onToggleBedroom2Door();         // update in Dashboard
                    localBedroom2Door = !localBedroom2Door;    // update locally
                    setInnerState(() {});        // refresh this builder
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
