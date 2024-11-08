import 'package:campainghn/widgets/web_slidbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/step_provider.dart';
import '../utils/constants.dart';
import 'form_card_widget.dart';

class WebFormWidget extends ConsumerWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController previewController;

  const WebFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.previewController,
    required GlobalKey<FormState> formkey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);

    final isToggle1 = ref.watch(toggle1Provider);
    final isToggle2 = ref.watch(toggle2Provider.state).state;

    final formKey = ref.watch(formKeyProvider);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
              vertical: Constants.verticalPadding,
            ),
            child: FormCard(
                ref: ref,
                formKey: formKey,
                currentStep: currentStep,
                subjectController: subjectController,
                previewController: previewController,
                nameController: nameController,
                emailController: emailController,
                isToggle1: isToggle1,
                isToggle2: isToggle2),
          ),
        ),
        Expanded(
          // flex: ,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
              vertical: Constants.verticalPadding,
            ),
            child: SlideBarWidget(
              currentStep: currentStep,
              ref: ref,
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable

