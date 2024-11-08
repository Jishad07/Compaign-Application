import 'package:campainghn/widgets/form_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/step_provider.dart';
import '../utils/constants.dart';
import '../utils/steplist_constant.dart';
import '../views/homescreen/functions/functions.dart';
import 'apptext_widget.dart';
import 'custom_button_widget.dart';
import 'custom_textfield_widget.dart';
import 'custom_toggle_widget.dart';

class MobileFormCard extends StatelessWidget {
   final WidgetRef ref;
  const MobileFormCard({
    super.key,
    required this.formkey,
    required this.currentStep,
    required this.subjectController,
    required this.previewController,
    required this.nameController,
    required this.emailController,
    required this.isToggle1,
    required this.isToggle2, required this.ref,
  });

  final GlobalKey<FormState> formkey;
  final int currentStep;
  final TextEditingController subjectController;
  final TextEditingController previewController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final bool isToggle1;
  final bool isToggle2;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      textsize: Constants.mobiletitleFontSize,
                      text: steps[currentStep].title,
                    ),
                    AppText(
                      text: steps[currentStep].subtitle,
                      textsize: Constants.mobilesubtitleFontSize,
                    ),
                  ],
                ),
                const SizedBox(height: Constants.verticalPadding),
                CustomInput(
                  label: 'Campaign Subject',
                  controller: subjectController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter the subject'
                      : null,
                ),
                const SizedBox(height: Constants.fieldSpacing),
                CustomInput(
                  label: 'Preview Text',
                  helpertext: "Keep this simple (around 50 characters)",
                  controller: previewController,
                  maximumLines: 5,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter preview text'
                      : null,
                ),
                const SizedBox(height: Constants.fieldSpacing),
                CustomInput(
                  label: '"From" Name',
                  controller: nameController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter Field 1'
                      : null,
                ),
                const SizedBox(width: 10),
                CustomInput(
                  label: '"From" Email',
                  controller: emailController,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter Field 2'
                      : null,
                ),
                const SizedBox(height: Constants.fieldSpacing),
                CustomToggleWidget(
                  toggleValue: isToggle2,
                   toggleProvider: toggle2Provider, 
                   toggleLabel: "Custom Audience", 
                   ref: ref),
               CustomToggleWidget(toggleValue: isToggle1, toggleProvider: toggle1Provider, toggleLabel: "Run only once per customer", ref: ref),
                const SizedBox(height: Constants.verticalPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Save Draft",
                        buttonColor: Colors.grey,
                        onPressed: () {
                          saveFormDraft(
                            emailController: emailController,
                            subjectController: subjectController,
                            isToggle1: isToggle1,
                            isToggle2: isToggle2,
                            nameController: nameController,
                            previewController: previewController,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: currentStep == steps.length - 1
                            ? "Submit"
                            : "Next Step",
                        buttonColor: Constants.primaryColor,
                        onPressed: () {
                          if (formkey.currentState?.validate() ??
                              false) {
                            if (currentStep < steps.length - 1) {
                              ref
                                  .read(currentStepProvider.state)
                                  .state++;
                              clearForm(
                                emailController: emailController,
                                nameController: nameController,
                                previewController: previewController,
                                subjectController: subjectController,
                              );
                              resetToggles(ref: ref);
                            } else {
                              submitForm(
                                ref: Ref,
                                context: context,
                                formKey: formkey,
                                emailController: emailController,
                                subjectController: subjectController,
                                previewController: previewController,
                                nameController: nameController,
                                isToggle1: isToggle1,
                                isToggle2: isToggle2,
                              );
                              clearForm(
                                emailController: emailController,
                                nameController: nameController,
                                previewController: previewController,
                                subjectController: subjectController,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}