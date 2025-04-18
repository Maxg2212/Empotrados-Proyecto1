import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lottie/lottie.dart';

import '../views/bedroom1_view.dart';
import '../views/bedroom2_view.dart';
import '../views/dining_room_view.dart';
import '../views/kitchen_view.dart';
import '../views/living_room_view.dart';
import 'main_access_view.dart';
import '../widgets/background_container.dart';

class DashboardView extends StatefulWidget {
  final String username;
  const DashboardView({super.key, required this.username});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _isFrontDoorOpen = false;
  bool _isBackDoorOpen = false;

  bool _isBedroom1LightOn = false;
  bool _isBedroom1DoorOpen = false;

  bool _isBedroom2LightOn = false;
  bool _isBedroom2DoorOpen = false;

  bool _isLivingRoomLightOn = false;
  bool _isDiningRoomLightOn = false;
  bool _isKitchenLightOn = false;

  void _toggleKitchenLight() => setState(() => _isKitchenLightOn = !_isKitchenLightOn);
  void _toggleDiningRoomLight() => setState(() => _isDiningRoomLightOn = !_isDiningRoomLightOn);
  void _toggleLivingRoomLight() => setState(() => _isLivingRoomLightOn = !_isLivingRoomLightOn);
  void _toggleBedroom2Light() => setState(() => _isBedroom2LightOn = !_isBedroom2LightOn);
  void _toggleBedroom2Door() => setState(() => _isBedroom2DoorOpen = !_isBedroom2DoorOpen);
  void _toggleBedroom1Light() => setState(() => _isBedroom1LightOn = !_isBedroom1LightOn);
  void _toggleBedroom1Door() => setState(() => _isBedroom1DoorOpen = !_isBedroom1DoorOpen);
  void _toggleFrontDoor() => setState(() => _isFrontDoorOpen = !_isFrontDoorOpen);
  void _toggleBackDoor() => setState(() => _isBackDoorOpen = !_isBackDoorOpen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // ✅ default AppBar restored
        title: const Text('Smart Home Dashboard'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.username}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildRoomTile(context, 'Main Access'),
                    _buildRoomTile(context, 'Bedroom 1'),
                    _buildRoomTile(context, 'Bedroom 2'),
                    _buildRoomTile(context, 'Living Room'),
                    _buildRoomTile(context, 'Dining Room'),
                    _buildRoomTile(context, 'Kitchen'),
                    _buildRoomTile(context, 'Garden'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomTile(BuildContext context, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF7D7F7D).withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: InkWell(
            onTap: () {
              switch (label) {
                case 'Main Access':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MainAccessView(
                      isFrontDoorOpen: _isFrontDoorOpen,
                      isBackDoorOpen: _isBackDoorOpen,
                      onToggleFrontDoor: _toggleFrontDoor,
                      onToggleBackDoor: _toggleBackDoor,
                    ),
                  ));
                  break;
                case 'Bedroom 1':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Bedroom1View(
                      isLightOn: _isBedroom1LightOn,
                      onToggleLight: _toggleBedroom1Light,
                      isBedroom1DoorOpen: _isBedroom1DoorOpen,
                      onToggleBedroom1Door: _toggleBedroom1Door,
                    ),
                  ));
                  break;
                case 'Bedroom 2':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Bedroom2View(
                      isLightOn: _isBedroom2LightOn,
                      onToggleLight: _toggleBedroom2Light,
                      isBedroom2DoorOpen: _isBedroom2DoorOpen,
                      onToggleBedroom2Door: _toggleBedroom2Door,
                    ),
                  ));
                  break;
                case 'Living Room':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LivingRoomView(
                      isLightOn: _isLivingRoomLightOn,
                      onToggleLight: _toggleLivingRoomLight,
                    ),
                  ));
                  break;
                case 'Dining Room':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DiningRoomView(
                      isLightOn: _isDiningRoomLightOn,
                      onToggleLight: _toggleDiningRoomLight,
                    ),
                  ));
                  break;
                case 'Kitchen':
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => KitchenView(
                      isLightOn: _isKitchenLightOn,
                      onToggleLight: _toggleKitchenLight,
                    ),
                  ));
                  break;
                default:
                  print("Tapped on $label");
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
