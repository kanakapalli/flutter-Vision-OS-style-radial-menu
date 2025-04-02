import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';
import 'dart:math' as math;

/// A circular menu widget that displays options in a wheel layout.
///
/// This widget handles the layout and display of menu options in a circular pattern,
/// with a glass-like appearance inspired by Vision OS.
class WheelMenu extends StatelessWidget {
  /// The list of options to display in the wheel.
  final List<MenuOption> options;

  /// Callback function when an option is selected.
  final Function(MenuOption) onOptionSelected;

  /// The index of the option that is currently being hovered.
  final int? hoveredIndex;

  /// Center text to display in the wheel (defaults to "MENU").
  final String centerText;

  /// Size of the wheel menu.
  final double size;

  /// Creates a wheel menu with the specified options.
  const WheelMenu({
    super.key,
    required this.options,
    required this.onOptionSelected,
    this.hoveredIndex,
    this.centerText = 'MENU',
    this.size = 220,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha((0.1 * 255).round()),
        border: Border.all(
          color: Colors.white.withAlpha((0.1 * 255).round()),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
            children: [
              // Center circle
              Center(
                child: Container(
                  width: size * 0.32, // ~70px for default size
                  height: size * 0.32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha((0.15 * 255).round()),
                    border: Border.all(
                      color: Colors.white.withAlpha((0.2 * 255).round()),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      centerText,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: size * 0.064, // ~14px for default size
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),

              // Dynamically position options around the wheel
              ...List.generate(options.length, (index) {
                // Calculate position based on angle
                final double angleRadians =
                    (index * (2 * math.pi / options.length));

                // Calculate alignment based on angle
                // sin for y, cos for x (adjusted for UI coordinate system)
                final double x = math.sin(angleRadians);
                final double y = -math.cos(angleRadians);

                return _buildOptionPosition(
                    options[index],
                    Alignment(x * 0.8, y * 0.8),
                    onOptionSelected,
                    hoveredIndex == index);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionPosition(MenuOption option, Alignment alignment,
      Function(MenuOption) onTap, bool isHovered) {
    return Align(
      alignment: alignment,
      child: OptionButton(
        option: option,
        onTap: () => onTap(option),
        isHovered: isHovered,
      ),
    );
  }
}
