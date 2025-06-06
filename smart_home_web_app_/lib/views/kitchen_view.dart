import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/background_container.dart'; 

class KitchenView extends StatelessWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;

  const KitchenView({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
  });

  @override
  Widget build(BuildContext context) {
    
    bool localIsOn = isLightOn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen'),
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
                    lightLabel: 'Kitchen Light',
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
