import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';

/// A button representing a menu option in the wheel menu.
///
/// This widget handles the rendering of a single option including
/// its icon, label, and hover effects.
class OptionButton extends StatelessWidget {
  /// The option data to display.
  final MenuOption option;

  /// Callback function when this option is tapped.
  final VoidCallback onTap;

  /// Whether this option is currently being hovered over.
  final bool isHovered;

  /// Creates a new option button.
  const OptionButton({
    super.key,
    required this.option,
    required this.onTap,
    this.isHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 50,
      height: 50,
      transform:
          isHovered ? (Matrix4.identity()..scale(1.1)) : Matrix4.identity(),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(isHovered ? 0.2 : 0.1),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: isHovered
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 0,
                )
              ]
            : [],
      ),
      child: Stack(
        children: [
          // Icon centered in the circle
          Center(
            child: Icon(
              option.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          // Label positioned below the button
          Positioned(
            bottom: -22,
            left: 0,
            right: 0,
            child: Text(
              option.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
