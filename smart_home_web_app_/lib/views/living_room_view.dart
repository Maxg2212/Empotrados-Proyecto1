import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/background_container.dart'; // 👈 Add background import

class LivingRoomView extends StatelessWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;

  const LivingRoomView({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
  });

  @override
  Widget build(BuildContext context) {
    // Local copy of the state so it can update the UI immediately
    bool localIsOn = isLightOn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Living Room'),
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
                    lightLabel: 'Living Room Light',
                    isOn: localIsOn,
                    onToggle: () {
                      onToggleLight();
                      localIsOn = !localIsOn;
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
