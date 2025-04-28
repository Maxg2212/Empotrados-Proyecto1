import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/background_container.dart';

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // No picture loading at start
  }

  Future<void> _takeNewPicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _imageUrl = 'https://www.gibbsgardens.com/wp-content/uploads/2025/04/18ad3e97-4484-e1d2-5b1d-a016bcea50c2-1510x1510-c-default.jpg';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New photo taken')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to take new picture')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garden'),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Center(
                    child: _isLoading
                        ? Lottie.asset(
                            'assets/lottie/loading.json',
                            width: 150,
                            repeat: true,
                          )
                        : _imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  _imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text(
                                'No picture available',
                                style: TextStyle(color: Colors.white70),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _glassButton(
                label: 'Take New Picture',
                onPressed: _takeNewPicture,
              ),
            ],
          ),
        ),
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
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
