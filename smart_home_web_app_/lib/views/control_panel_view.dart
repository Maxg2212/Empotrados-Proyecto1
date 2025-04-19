import 'package:flutter/material.dart';
import '../widgets/background_container.dart';

class ControlPanelView extends StatefulWidget {
  final int totalLights;
  final List<bool> lightsOn;
  final int totalDoors;
  final List<bool> doorsOpen;

  final void Function(bool) onSetAllLights;
  final void Function(bool) onSetAllDoors;

  const ControlPanelView({
    super.key,
    required this.totalLights,
    required this.lightsOn,
    required this.totalDoors,
    required this.doorsOpen,
    required this.onSetAllLights,
    required this.onSetAllDoors,
  });

  @override
  State<ControlPanelView> createState() => _ControlPanelViewState();
}

class _ControlPanelViewState extends State<ControlPanelView> {
  late List<bool> localLights;
  late List<bool> localDoors;

  @override
  void initState() {
    super.initState();
    localLights = List.from(widget.lightsOn);
    localDoors = List.from(widget.doorsOpen);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lightsOnCount = localLights.where((e) => e).length;
    final doorsOpenCount = localDoors.where((e) => e).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Panel'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildGlassCard(
                title: '💡 Lights On: $lightsOnCount / ${widget.totalLights}',
                buttons: [
                  _glassButton(
                    label: 'Turn All ON',
                    onPressed: () {
                      widget.onSetAllLights(true);
                      setState(() => localLights = List.filled(widget.totalLights, true));
                      _showSnackBar('All lights turned ON');
                    },
                  ),
                  _glassButton(
                    label: 'Turn All OFF',
                    onPressed: () {
                      widget.onSetAllLights(false);
                      setState(() => localLights = List.filled(widget.totalLights, false));
                      _showSnackBar('All lights turned OFF');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildGlassCard(
                title: '🚪 Doors Open: $doorsOpenCount / ${widget.totalDoors}',
                buttons: [
                  _glassButton(
                    label: 'Open All',
                    onPressed: () {
                      widget.onSetAllDoors(true);
                      setState(() => localDoors = List.filled(widget.totalDoors, true));
                      _showSnackBar('All doors opened');
                    },
                  ),
                  _glassButton(
                    label: 'Close All',
                    onPressed: () {
                      widget.onSetAllDoors(false);
                      setState(() => localDoors = List.filled(widget.totalDoors, false));
                      _showSnackBar('All doors closed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required String title,
    required List<Widget> buttons,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF7D7F7D).withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: buttons[0]),
              const SizedBox(width: 12),
              Expanded(child: buttons[1]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _glassButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF474B4E).withOpacity(0.9),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
