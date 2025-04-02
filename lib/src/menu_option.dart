import 'package:flutter/material.dart';

/// Represents a single option in the wheel menu.
///
/// Each option consists of an icon and a label that will be displayed
/// in the wheel menu.
class MenuOption {
  /// The icon to display for this option.
  final IconData icon;

  /// The text label to display below the icon.
  final String label;

  /// Creates a new menu option with the specified icon and label.
  MenuOption({
    required this.icon,
    required this.label,
  });
}
