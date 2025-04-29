import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/background_container.dart';
import '../services/api_service.dart';

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  Uint8List? _imageBytes; // Use bytes, not URL
  bool _isLoading = false;

  Future<void> _takeNewPicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bytes = await ApiService.takeGardenPicture();

      if (bytes != null) {
        setState(() {
          _imageBytes = bytes;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New picture taken successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to take new picture')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error while taking picture')),
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
                        : _imageBytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.memory(
                                  _imageBytes!,
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
