import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/step_provider.dart';
import '../utils/constants.dart';
import '../utils/steplist_constant.dart';
import 'mobile_form_card_widget.dart';

class MobileFormWidget extends ConsumerWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController previewController;

  // ignore: prefer_const_constructors_in_immutables
  MobileFormWidget({
    super.key,
    required this.formkey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.previewController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);
    final isToggle1 = ref.watch(toggle1Provider);
    final isToggle2 = ref.watch(toggle2Provider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.horizontalPadding,
            vertical: Constants.verticalPadding,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Constants.primaryColor,
                child: Text(
                  "${currentStep + 1}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                steps[currentStep].title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
              vertical: Constants.verticalPadding,
            ),
            child: MobileFormCard(
              formkey: formkey,
               currentStep: currentStep, 
               subjectController: subjectController, 
               previewController: previewController, 
               nameController: nameController, 
               emailController: emailController, 
               isToggle1: isToggle1, 
               isToggle2: isToggle2,
               ref: ref,
               ),
          ),
        ),
      ],
    );
  }
}


