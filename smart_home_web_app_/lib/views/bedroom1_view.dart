import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/light_control_card.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart'; 
import '../services/api_service.dart'; // We use this for API

class Bedroom1View extends StatefulWidget {
  final bool isLightOn;
  final VoidCallback onToggleLight;
  final bool isBedroom1DoorOpen;

  const Bedroom1View({
    super.key,
    required this.isLightOn,
    required this.onToggleLight,
    required this.isBedroom1DoorOpen,
  });

  @override
  State<Bedroom1View> createState() => _Bedroom1ViewState();
}

class _Bedroom1ViewState extends State<Bedroom1View> {
  late bool _localIsOn;
  late bool _localBedroom1DoorOpen;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _localIsOn = widget.isLightOn;
    _localBedroom1DoorOpen = widget.isBedroom1DoorOpen;
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _refreshBedroomDoor();
    });
  }

  Future<void> _refreshBedroomDoor() async {
    try {
      final doorsData = await ApiService.getDoorsStatus();
      if (doorsData != null) {
        final bedroom1DoorStatus = doorsData['bedroom1_door'] ?? false;
        if (bedroom1DoorStatus != _localBedroom1DoorOpen) {
          setState(() {
            _localBedroom1DoorOpen = bedroom1DoorStatus;
          });
        }
      }
    } catch (e) {
      print('Error refreshing Bedroom 1 door from getDoorsStatus: $e');
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
        title: const Text('Bedroom 1'),
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
                isOpen: _localBedroom1DoorOpen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
