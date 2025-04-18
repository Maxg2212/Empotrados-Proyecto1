import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart'; 

class Bedroom1View extends StatelessWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;

  final bool isBedroom1DoorOpen;
  final VoidCallback onToggleBedroom1Door;

  const Bedroom1View({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
    required this.isBedroom1DoorOpen,
    required this.onToggleBedroom1Door,
  });

  @override
  Widget build(BuildContext context) {
    // Local copy of the state so it can update the UI immediately
    bool localIsOn = isLightOn;
    bool localBedroom1Door = isBedroom1DoorOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bedroom 1'),
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

                  LightControlCard(
                    lightLabel: 'Bedroom Light',
                    isOn: localIsOn,
                    onToggle: () {
                      onToggleLight();
                      localIsOn = !localIsOn;
                      setInnerState(() {});
                    },
                  ),

                  const SizedBox(height: 24),

                  DoorControlCard(
                    doorLabel: 'Bedroom Door',
                    isOpen: localBedroom1Door,
                    onToggle: () {
                      onToggleBedroom1Door();
                      localBedroom1Door = !localBedroom1Door;
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
