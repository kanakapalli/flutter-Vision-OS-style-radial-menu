# Vision Wheel Menu

![Vision Wheel Menu Demo](demo.gif)

A beautiful, customizable Vision OS-style radial menu for Flutter that appears on long press. This package provides a sleek, glass-morphic wheel menu that allows users to select options by dragging and releasing.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  vision_wheel_menu: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Implementation

```dart
import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define your menu options
    final options = [
      MenuOption(icon: Icons.home, label: 'Home'),
      MenuOption(icon: Icons.edit, label: 'Edit'),
      MenuOption(icon: Icons.share, label: 'Share'),
      MenuOption(icon: Icons.delete, label: 'Delete'),
    ];

    return Stack(
      children: [
        // Your existing UI here
        
        // Add the wheel menu widget
        VisionWheelMenuWidget(
          options: options,
          onOptionSelected: (option) {
            print('Selected: ${option.label}');
            // Handle option selection here
          },
        ),
      ],
    );
  }
}
```

### How It Works

1. User long presses anywhere on the screen
2. The wheel menu appears at the touch position
3. User drags finger to the desired option (it highlights as they hover)
4. User releases finger to select the option
5. The selected option is passed to your callback function

## Components

### MenuOption

This is the data model for each option in the wheel menu.

```dart
MenuOption(
  icon: Icons.home,  // Flutter IconData
  label: 'Home',     // Text label
)
```

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| icon | IconData | The icon to display for this option |
| label | String | The text label to display below the icon |

### VisionWheelMenuWidget

The main widget that provides the complete wheel menu functionality.

```dart
VisionWheelMenuWidget(
  options: options,
  onOptionSelected: handleOptionSelected,
  centerText: 'MENU',
  wheelSize: 220,
  animationDuration: Duration(milliseconds: 200),
)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| options | List\<MenuOption\> | The options to display in the wheel menu | Required |
| onOptionSelected | Function(MenuOption) | Callback when an option is selected | Required |
| centerText | String | Text to display in the center of the wheel | 'MENU' |
| wheelSize | double | Size of the wheel menu in pixels | 220.0 |
| animationDuration | Duration | Duration of the appearance/disappearance animation | 200ms |

### WheelMenu

For advanced customization, you can use the WheelMenu widget directly:

```dart
WheelMenu(
  options: options,
  hoveredIndex: 2,  // Optional: pre-highlight an option
  onOptionSelected: handleOptionSelected,
  centerText: 'MENU',
  size: 220,
)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| options | List\<MenuOption\> | The options to display in the wheel menu | Required |
| onOptionSelected | Function(MenuOption) | Callback when an option is selected | Required |
| hoveredIndex | int? | Index of the option to highlight | null |
| centerText | String | Text to display in the center of the wheel | 'MENU' |
| size | double | Size of the wheel menu in pixels | 220.0 |

## Advanced Usage

### Custom Number of Options

The menu automatically adapts to any number of options:

```dart
final List<MenuOption> _options = [
  MenuOption(icon: Icons.home, label: 'Home'),
  MenuOption(icon: Icons.edit, label: 'Edit'),
  MenuOption(icon: Icons.share, label: 'Share'),
  // Add as many as you need - the wheel adapts!
];
```

### Custom Styling (Coming Soon)

In future releases, we'll add more customization options including:
- Custom colors
- Option size
- Font styles
- Background opacity

## Complete Example

For a complete example, see the [example folder](https://github.com/yourusername/vision_wheel_menu/tree/main/example).

```dart
import 'package:flutter/material.dart';
import 'package:vision_wheel_menu/vision_wheel_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vision Wheel Menu Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedOption = '';

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
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.3, 0.3),
                radius: 0.8,
                colors: [
                  Color(0xFF1E1E2A),
                  Color(0xFF0A0A0A),
                ],
              ),
            ),
            child: Center(
              child: Text(
                'Selected: $_selectedOption',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          
          // Wheel menu
          VisionWheelMenuWidget(
            options: _options,
            onOptionSelected: (option) {
              setState(() {
                _selectedOption = option.label;
              });
              
              print('Selected: ${option.label}');
            },
          ),
        ],
      ),
    );
  }
}
```

## Requirements

- Flutter 2.10.0 or higher
- Dart 2.16.0 or higher

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

Inspired by Apple's Vision OS interface design.