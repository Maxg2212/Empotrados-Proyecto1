import 'package:flutter/material.dart';
import 'package:smart_home_web_app_/views/bedroom1_view.dart';
import 'package:smart_home_web_app_/views/bedroom2_view.dart';
import 'package:smart_home_web_app_/views/dining_room_view.dart';
import 'package:smart_home_web_app_/views/kitchen_view.dart';
import 'package:smart_home_web_app_/views/living_room_view.dart';
import 'main_access_view.dart';

class DashboardView extends StatefulWidget {
  final String username;
  const DashboardView({super.key, required this.username});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  // Door state lives here
  bool _isFrontDoorOpen = false;
  bool _isBackDoorOpen = false;

  bool _isBedroom1LightOn = false; 
  bool _isBedroom1DoorOpen = false; 

  bool _isBedroom2LightOn = false;
  bool _isBedroom2DoorOpen = false; 

  bool _isLivingRoomLightOn = false; 

  bool _isDiningRoomLightOn = false; 

  bool _isKitchenLightOn = false; 

  void _toggleKitchenLight(){
    setState(() {
      _isKitchenLightOn =! _isKitchenLightOn;
    });
  }

  void _toggleDiningRoomLight(){
    setState(() {
      _isDiningRoomLightOn =! _isDiningRoomLightOn;
    });
  }

  void _toggleLivingRoomLight(){
    setState(() {
      _isLivingRoomLightOn =! _isLivingRoomLightOn;
    });
  }

   void _toggleBedroom2Light(){
    setState(() {
      _isBedroom2LightOn =! _isBedroom2LightOn;
    });
  }

  void _toggleBedroom2Door(){
    setState(() {
      _isBedroom2DoorOpen =! _isBedroom2DoorOpen;
    });
  }

  void _toggleBedroom1Door(){
    setState(() {
      _isBedroom1DoorOpen =! _isBedroom1DoorOpen;
    });
  }

  void _toggleBedroom1Light(){
    setState(() {
      _isBedroom1LightOn =! _isBedroom1LightOn;
    });
  }

  void _toggleFrontDoor() {
    setState(() {
      _isFrontDoorOpen = !_isFrontDoorOpen;
    });
  }

  void _toggleBackDoor() {
    setState(() {
      _isBackDoorOpen = !_isBackDoorOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.username}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // GridView starts here
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRoomTile(BuildContext context, String label) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          if (label == 'Main Access') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainAccessView(
                  isFrontDoorOpen: _isFrontDoorOpen,
                  isBackDoorOpen: _isBackDoorOpen,
                  onToggleFrontDoor: _toggleFrontDoor,
                  onToggleBackDoor: _toggleBackDoor,
                ),
              ),
            );
          } else if (label == 'Bedroom 1'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bedroom1View(
                  isLightOn: _isBedroom1LightOn,
                  onToggleLight: _toggleBedroom1Light,
                  isBedroom1DoorOpen: _isBedroom1DoorOpen,
                  onToggleBedroom1Door: _toggleBedroom1Door,
                ),
              ),
            );
          } else if (label == 'Bedroom 2'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bedroom2View(
                  isLightOn: _isBedroom2LightOn,
                  onToggleLight: _toggleBedroom2Light,
                  isBedroom2DoorOpen: _isBedroom2DoorOpen,
                  onToggleBedroom2Door: _toggleBedroom2Door,
                ),
              ),
            );
            
          }else if (label == 'Living Room'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LivingRoomView(
                  isLightOn: _isLivingRoomLightOn,
                  onToggleLight: _toggleLivingRoomLight,
                ),
              ),
            );

          }else if (label == 'Dining Room'){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiningRoomView(
                  isLightOn: _isDiningRoomLightOn,
                  onToggleLight: _toggleDiningRoomLight,
                ),
              ),
            );
          }else if (label == "Kitchen"){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KitchenView(
                  isLightOn: _isKitchenLightOn,
                  onToggleLight: _toggleKitchenLight,
                ),
              ),
            );

          }else {

            print("Tapped");

          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
