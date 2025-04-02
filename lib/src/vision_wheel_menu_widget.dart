import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';
import 'dart:math' as math;
import 'wheel_menu.dart';

/// A widget that displays a wheel menu on long press.
///
/// This widget handles the gesture detection, positioning, and animation
/// of the wheel menu. It should be placed in a Stack to overlay other content.
class VisionWheelMenuWidget extends StatefulWidget {
  /// The options to display in the wheel menu.
  final List<MenuOption> options;

  /// Callback function when an option is selected.
  final Function(MenuOption) onOptionSelected;

  /// Text to display in the center of the wheel (defaults to "MENU").
  final String centerText;

  /// Size of the wheel menu (defaults to 220).
  final double wheelSize;

  /// Animation duration for menu appearance (defaults to 200ms).
  final Duration animationDuration;

  /// Creates a vision wheel menu widget.
  const VisionWheelMenuWidget({
    super.key,
    required this.options,
    required this.onOptionSelected,
    this.centerText = 'MENU',
    this.wheelSize = 220,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<VisionWheelMenuWidget> createState() => _VisionWheelMenuWidgetState();
}

class _VisionWheelMenuWidgetState extends State<VisionWheelMenuWidget> {
  bool _showMenu = false;
  Offset _menuPosition = Offset.zero;
  int? _hoveredOptionIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: _handleLongPressStart,
      onLongPressMoveUpdate: _handleLongPressMoveUpdate,
      onLongPressEnd: _handleLongPressEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            if (_showMenu)
              Positioned(
                left: _menuPosition.dx - (widget.wheelSize / 2),
                top: _menuPosition.dy - (widget.wheelSize / 2),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: widget.animationDuration,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: 0.9 + (0.1 * value),
                        child: child,
                      ),
                    );
                  },
                  child: WheelMenu(
                    options: widget.options,
                    hoveredIndex: _hoveredOptionIndex,
                    onOptionSelected: widget.onOptionSelected,
                    centerText: widget.centerText,
                    size: widget.wheelSize,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    setState(() {
      _menuPosition = details.globalPosition;
      _showMenu = true;
      _hoveredOptionIndex = null;
    });
  }

  void _handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    // Calculate which option is being hovered
    if (_showMenu) {
      final Offset localPosition = details.globalPosition -
          _menuPosition +
          Offset(widget.wheelSize / 2, widget.wheelSize / 2);
      final Offset center = Offset(widget.wheelSize / 2, widget.wheelSize / 2);

      // Calculate the vector from center to finger
      final double dx = localPosition.dx - center.dx;
      final double dy = localPosition.dy - center.dy;

      // Calculate distance from center
      final double distance = math.sqrt(dx * dx + dy * dy);

      // Don't highlight any option if finger is in the center circle (radius 40)
      final double centerRadius =
          widget.wheelSize * 0.18; // ~40px for default 220px size
      if (distance < centerRadius) {
        if (_hoveredOptionIndex != null) {
          setState(() {
            _hoveredOptionIndex = null;
          });
        }
        return;
      }

      // Calculate angle (0° is up, going clockwise)
      double angle = math.atan2(dy, dx) * (180 / math.pi);
      angle = (angle + 90) % 360;
      if (angle < 0) angle += 360;

      // Calculate option angles dynamically based on number of options
      final int numOptions = widget.options.length;
      final double sliceAngle = 360 / numOptions;

      // Find closest option by angle
      int closestOption = 0;
      double minAngleDiff = 360;

      for (int i = 0; i < numOptions; i++) {
        final double optionAngle = i * sliceAngle;

        // Calculate angular distance (considering wrap-around)
        double angleDiff = (angle - optionAngle).abs();
        if (angleDiff > 180) angleDiff = 360 - angleDiff;

        if (angleDiff < minAngleDiff) {
          minAngleDiff = angleDiff;
          closestOption = i;
        }
      }

      if (_hoveredOptionIndex != closestOption) {
        setState(() {
          _hoveredOptionIndex = closestOption;
        });
      }
    }
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    // If an option is hovered when released, select it
    if (_hoveredOptionIndex != null) {
      widget.onOptionSelected(widget.options[_hoveredOptionIndex!]);
    }

    setState(() {
      _showMenu = false;
    });
  }
}
