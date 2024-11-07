// import 'package:flutter/material.dart';


// class CustomToggleWidget extends ConsumerWidget {
//   final String title;
//   final String subtitle;
//   final StateProvider<bool> toggleProvider;

//   CustomToggleWidget({
//     required this.title,
//     required this.subtitle,
//     required this.toggleProvider,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Access the toggle state from Riverpod provider
//     final bool isToggled = ref.watch(toggleProvider);

//     return SwitchListTile(
//       activeColor: Colors.orange,
//       inactiveThumbColor: Colors.grey,
//       activeTrackColor: Colors.orange.shade200,
//       inactiveTrackColor: Colors.grey.shade300,
//       title: Text(title),
//       subtitle: Text(subtitle),
//       value: isToggled,
//       onChanged: (value) {
//         // Update the toggle state in Riverpod
//         ref.read(toggleProvider.notifier).state = value;
//       },
//     );
//   }
// }
