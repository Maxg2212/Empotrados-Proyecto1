import 'package:flutter/material.dart';
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
          } else {
            print('$label tapped');
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
