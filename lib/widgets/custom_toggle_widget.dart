import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomToggleWidget extends StatelessWidget {
  const CustomToggleWidget({
    super.key,
    required this.toggleValue,  // The current value of the toggle
    required this.toggleProvider, // The Riverpod provider to control
    required this.toggleLabel, // The label to display for the toggle
    required this.ref, // The WidgetRef instance
  });

  final bool toggleValue;
  final String toggleLabel;
  final WidgetRef ref;
  final StateProvider<bool> toggleProvider;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Colors.orange,
      inactiveThumbColor: Colors.grey,
      activeTrackColor: Colors.orange.shade200,
      inactiveTrackColor: Colors.grey.shade300,
      title: Text(toggleLabel), // Dynamically display the label
      value: toggleValue,
      onChanged: (value) {
        // Update the state of the toggle using the correct provider
        ref.read(toggleProvider.state).state = value;
      },
    );
  }
}
