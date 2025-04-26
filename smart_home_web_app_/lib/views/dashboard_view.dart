import 'package:flutter/material.dart';

import '../views/bedroom1_view.dart';
import '../views/bedroom2_view.dart';
import '../views/dining_room_view.dart';
import '../views/kitchen_view.dart';
import '../views/living_room_view.dart';
import 'main_access_view.dart';
import '../views/control_panel_view.dart';
import '../widgets/background_container.dart';
import '../services/api_service.dart';
import '../views/garden_view.dart';


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

  @override
  void initState() {
    super.initState();
    _fetchDoorStatuses(); 
  }

  Future<void> _fetchDoorStatuses() async {
    try {
      final doorData = await ApiService.getDoorsStatus();
      if (doorData != null) {
        setState(() {
          _isFrontDoorOpen = doorData['front_door'] ?? false;
          _isBackDoorOpen = doorData['back_door'] ?? false;
          _isBedroom1DoorOpen = doorData['bedroom1_door'] ?? false;
          _isBedroom2DoorOpen = doorData['bedroom2_door'] ?? false;
        });
      }
    } catch (e) {
      print('Error fetching door statuses: $e');
    }
  }

  void _toggleKitchenLight() async {
    final newStatus = !_isKitchenLightOn;
    final success = await ApiService.updateLight('kitchen', newStatus);
    if (success) {
      setState(() => _isKitchenLightOn = newStatus);
    }
  }

  void _toggleDiningRoomLight() async {
    final newStatus = !_isDiningRoomLightOn;
    final success = await ApiService.updateLight('dining_room', newStatus);
    if (success) {
      setState(() => _isDiningRoomLightOn = newStatus);
    }
  }

  void _toggleLivingRoomLight() async {
    final newStatus = !_isLivingRoomLightOn;
    final success = await ApiService.updateLight('living_room', newStatus);
    if (success) {
      setState(() => _isLivingRoomLightOn = newStatus);
    }
  }

  void _toggleBedroom2Light() async {
    final newStatus = !_isBedroom2LightOn;
    final success = await ApiService.updateLight('bedroom2', newStatus);
    if (success) {
      setState(() => _isBedroom2LightOn = newStatus);
    }
  }

  void _toggleBedroom2Door() => setState(() => _isBedroom2DoorOpen = !_isBedroom2DoorOpen);
  
  void _toggleBedroom1Light() async {
    final newStatus = !_isBedroom1LightOn;
    final success = await ApiService.updateLight('bedroom1', newStatus);
    if (success) {
      setState(() => _isBedroom1LightOn = newStatus);
    }
  }

  void _toggleBedroom1Door() => setState(() => _isBedroom1DoorOpen = !_isBedroom1DoorOpen);
  void _toggleFrontDoor() => setState(() => _isFrontDoorOpen = !_isFrontDoorOpen);
  void _toggleBackDoor() => setState(() => _isBackDoorOpen = !_isBackDoorOpen);

  @override
  Widget build(BuildContext context) {
    final lights = [
      _isLivingRoomLightOn,
      _isKitchenLightOn,
      _isDiningRoomLightOn,
      _isBedroom1LightOn,
      _isBedroom2LightOn
    ];

    final doors = [
      _isFrontDoorOpen,
      _isBackDoorOpen,
      _isBedroom1DoorOpen,
      _isBedroom2DoorOpen
    ];

    return Scaffold(
      appBar: AppBar(
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ControlPanelView(
                        totalLights: lights.length,
                        lightsOn: lights,
                        totalDoors: doors.length,
                        doorsOpen: doors,
                        onSetAllLights: (value) async {
                          final success = await ApiService.updateAllLights(value);
                          if (success) {
                            setState(() {
                              _isLivingRoomLightOn = value;
                              _isKitchenLightOn = value;
                              _isDiningRoomLightOn = value;
                              _isBedroom1LightOn = value;
                              _isBedroom2LightOn = value;
                            });
                          }
                        },
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '💡 Lights On: ${lights.where((e) => e).length} / ${lights.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        '🚪 Doors Open: ${doors.where((e) => e).length} / ${doors.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
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
    final Map<String, String> imageMap = {
      'Main Access': 'assets/images/main_access.jpg',
      'Bedroom 1': 'assets/images/bedroom1.jpg',
      'Bedroom 2': 'assets/images/bedroom2.jpg',
      'Living Room': 'assets/images/living_room.jpg',
      'Dining Room': 'assets/images/dining_room.jpg',
      'Kitchen': 'assets/images/kitchen.jpg',
      'Garden': 'assets/images/garden.jpg',
    };

    final imagePath = imageMap[label] ?? 'assets/images/default.jpg';

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => _handleRoomTap(context, label),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRoomTap(BuildContext context, String label) {
    switch (label) {
      case 'Main Access':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainAccessView(
            isFrontDoorOpen: _isFrontDoorOpen,
            isBackDoorOpen: _isBackDoorOpen,
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
      case 'Garden':
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => const GardenView(),
      ));
      break;
      default:
        print("Tapped on $label");
    }
  }
}
