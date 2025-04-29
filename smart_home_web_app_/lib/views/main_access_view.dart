import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/door_control_card.dart';
import '../widgets/background_container.dart';
import '../services/api_service.dart';

class MainAccessView extends StatefulWidget {
  final bool isFrontDoorOpen;
  final bool isBackDoorOpen;

  const MainAccessView({
    super.key,
    required this.isFrontDoorOpen,
    required this.isBackDoorOpen,
  });

  @override
  State<MainAccessView> createState() => _MainAccessViewState();
}

class _MainAccessViewState extends State<MainAccessView> {
  late bool _localFrontDoorOpen;
  late bool _localBackDoorOpen;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _localFrontDoorOpen = widget.isFrontDoorOpen;
    _localBackDoorOpen = widget.isBackDoorOpen;

    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _refreshDoors();
    });
  }

  Future<void> _refreshDoors() async {
    try {
      final doorData = await ApiService.getDoorsStatus();
      if (doorData != null) {
        setState(() {
          // Only update if there's a real change
          if (_localFrontDoorOpen != (doorData['front_door'] ?? false)) {
            _localFrontDoorOpen = doorData['front_door'] ?? false;
          }
          if (_localBackDoorOpen != (doorData['back_door'] ?? false)) {
            _localBackDoorOpen = doorData['back_door'] ?? false;
          }
        });
      }
    } catch (e) {
      print('Error refreshing door statuses: $e');
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
        title: const Text('Main Access'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Front door monitoring
              DoorControlCard(
                doorLabel: 'Front Door',
                isOpen: _localFrontDoorOpen,
              ),

              const SizedBox(height: 24),

              // Back door monitoring
              DoorControlCard(
                doorLabel: 'Back Door',
                isOpen: _localBackDoorOpen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
