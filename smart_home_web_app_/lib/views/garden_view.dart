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
    
  }

  Future<void> _fetchLastPicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _imageUrl = 'https://images.immediate.co.uk/production/volatile/sites/10/2024/01/2048x1365-Potager-Garden-SEO-GOTY-Competition-2018RobertBaileyScottNH180718GWRBS18009-11935f6.jpg';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loaded last picture (demo)')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load last picture')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _takeNewPicture() async {
    setState(() {
      _isLoading = true;
    });

    try {
      
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _imageUrl = 'https://www.robertlandscapes.com/wp-content/uploads/2023/11/Blog-image-Multi-Level-Garden-Design.jpg';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New picture taken (demo)')),
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
              Row(
                children: [
                  Expanded(
                    child: _glassButton(
                      label: 'Take New Picture',
                      onPressed: _takeNewPicture,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _glassButton(
                      label: 'See Last Picture',
                      onPressed: _fetchLastPicture,
                    ),
                  ),
                ],
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
