import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vision Wheel Menu Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedOption = '';
  bool _showSelectionInfo = false;

  final List<MenuOption> _options = [
    MenuOption(icon: Icons.home, label: 'Home'),
    MenuOption(icon: Icons.edit, label: 'Edit'),
    MenuOption(icon: Icons.share, label: 'Share'),
    MenuOption(icon: Icons.delete, label: 'Delete'),
    MenuOption(icon: Icons.file_copy, label: 'New'),
    MenuOption(icon: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.3, 0.3),
                radius: 0.8,
                colors: [
                  Color(0xFF1E1E2A),
                  Color(0xFF0A0A0A),
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),

          // Second gradient for visual effect
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.7, 0.7),
                radius: 0.8,
                colors: [
                  const Color(0xFF5C60FF).withAlpha((0.1 * 255).round()),
                  Colors.transparent,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // Instructions and selection info
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Press and hold anywhere to show the wheel menu',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Drag to select an option, then release',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                // Selection info
                if (_showSelectionInfo)
                  AnimatedOpacity(
                    opacity: _showSelectionInfo ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.1 * 255).round()),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withAlpha((0.1 * 255).round())),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _getIconForOption(_selectedOption),
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Selected: $_selectedOption',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Console: Selected option logged',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Wheel menu
          VisionWheelMenuWidget(
            options: _options,
            onOptionSelected: (option) {
              // Log to console
              print('Selected: ${option.label}');

              // Update UI
              setState(() {
                _selectedOption = option.label;
                _showSelectionInfo = true;

                // Auto-hide selection info after 3 seconds
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    setState(() {
                      _showSelectionInfo = false;
                    });
                  }
                });
              });
            },
          ),
        ],
      ),
    );
  }

  // Helper method to get the icon for the selected option
  IconData _getIconForOption(String label) {
    for (var option in _options) {
      if (option.label == label) {
        return option.icon;
      }
    }
    return Icons.check_circle;
  }
}
