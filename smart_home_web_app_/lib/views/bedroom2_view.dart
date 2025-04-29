import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart';
import '../services/api_service.dart'; // 👈 Needed for fetching doors status

class Bedroom2View extends StatefulWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;
  final bool isBedroom2DoorOpen;

  const Bedroom2View({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
    required this.isBedroom2DoorOpen,
  });

  @override
  State<Bedroom2View> createState() => _Bedroom2ViewState();
}

class _Bedroom2ViewState extends State<Bedroom2View> {
  late bool _localIsOn;
  late bool _localBedroom2DoorOpen;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _localIsOn = widget.isLightOn;
    _localBedroom2DoorOpen = widget.isBedroom2DoorOpen;
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _refreshBedroom2Door();
    });
  }

  Future<void> _refreshBedroom2Door() async {
    try {
      final doorsData = await ApiService.getDoorsStatus();
      if (doorsData != null) {
        final bedroom2DoorStatus = doorsData['bedroom2_door'] ?? false;
        if (bedroom2DoorStatus != _localBedroom2DoorOpen) {
          setState(() {
            _localBedroom2DoorOpen = bedroom2DoorStatus;
          });
        }
      }
    } catch (e) {
      print('Error refreshing Bedroom 2 door from getDoorsStatus: $e');
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bedroom 2'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              LightControlCard(
                lightLabel: 'Bedroom Light',
                isOn: _localIsOn,
                onToggle: () {
                  widget.onToggleLight();
                  setState(() {
                    _localIsOn = !_localIsOn;
                  });
                },
              ),

              const SizedBox(height: 24),

              DoorControlCard(
                doorLabel: 'Bedroom Door',
                isOpen: _localBedroom2DoorOpen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
