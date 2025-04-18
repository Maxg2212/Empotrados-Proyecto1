import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';


class DiningRoomView extends StatelessWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;

  const DiningRoomView({
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
        title: const Text('Dining Room'),
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
                  lightLabel: 'Dining Room Light',
                  isOn: localIsOn,
                  onToggle: () {
                    onToggleLight(); // updates global state in DashboardView
                    localIsOn = !localIsOn; // updates this screen instantly
                    setInnerState(() {});   // triggers rebuild
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
