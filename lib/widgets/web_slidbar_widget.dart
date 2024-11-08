import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/step_provider.dart';
import '../utils/constants.dart';
import '../utils/steplist_constant.dart';

// ignore: must_be_immutable
class SlideBarWidget extends StatelessWidget {
  WidgetRef ref;
  SlideBarWidget({
    super.key,
    required this.currentStep,
    required this.ref,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (context, index) {
            final step = steps[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: currentStep == index
                    ? Constants.primaryColor
                    : Colors.white,
                radius: 20,
                child: Text("${index + 1}"),
              ),
              title: Text(step.title,),
              subtitle: Text(step.subtitle),
              onTap: () {
                ref.read(currentStepProvider.state).state = index;
              },
            );
          },
        ),
      ),
    );
  }
}