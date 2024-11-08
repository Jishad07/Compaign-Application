import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/step_provider.dart';
import '../utils/constants.dart';
import '../utils/steplist_constant.dart';
import '../views/homescreen/functions/functions.dart';
import 'apptext_widget.dart';
import 'custom_button_widget.dart';
import 'custom_textfield_widget.dart';
import 'custom_toggle_widget.dart';

class FormCard extends StatelessWidget {
  final WidgetRef ref;
  const FormCard({
    super.key,
    required this.formKey,
    required this.currentStep,
    required this.subjectController,
    required this.previewController,
    required this.nameController,
    required this.emailController,
    required this.isToggle1,
    required this.isToggle2,
    required this.ref,
  });

  final GlobalKey<FormState> formKey;
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
            key: formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      text: steps[currentStep].title,
                      textsize: Constants.titleFontSize,
                    ),
                    AppText(
                      text: steps[currentStep].subtitle,
                      textsize: Constants.subtitleFontSize,
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
                Row(
                  children: [
                    Expanded(
                      child: CustomInput(
                        label: '"From" Name',
                        controller: nameController,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter Field 1'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomInput(
                        label: '"From" Email',
                        controller: emailController,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter Field 2'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Constants.fieldSpacing),
                 CustomToggleWidget(
                  toggleValue: isToggle1,
                  toggleProvider: toggle1Provider,  
                  toggleLabel: 'Run only once per customer',
                  ref: ref, 
                  
                ),
                CustomToggleWidget(
                  toggleValue: isToggle2,
                  toggleProvider: toggle2Provider,  
                  toggleLabel: 'Custom audience', 
                  ref: ref, 
                  
                ),
              
               
                const SizedBox(height: Constants.verticalPadding),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        textcolor: Constants.primaryColor,
                        text: "Save Draft",
                        onPressed: () {
                          saveFormDraft(
                              emailController: emailController,
                              isToggle1: isToggle1,
                              isToggle2: isToggle2,
                              nameController: nameController,
                              previewController: previewController,
                              subjectController: subjectController);
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        textcolor: Colors.white,
                        text: currentStep == steps.length - 1
                            ? "Submit"
                            : "Next Step",
                        buttonColor: Constants.primaryColor,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            if (currentStep < steps.length - 1) {
                              ref.read(currentStepProvider.state).state++;
                              clearForm(
                                  emailController: emailController,
                                  nameController: nameController,
                                  previewController: previewController,
                                  subjectController: subjectController);
                              resetToggles(ref: ref);
                            } else {
                              final formData = {
                                'name': nameController.text,
                                'email': emailController.text,
                                'subject': subjectController.text,
                                'previewText': previewController.text,
                                'runOncePerCustomer': ref.read(toggle1Provider),
                                'customAudience': ref.read(toggle2Provider),
                              };
                              String jsonData = jsonEncode(formData);
                              print(
                                  'Form Submission Data in JSON format: $jsonData');
                              submitForm(
                                ref: Ref,
                                context: context,
                                formKey: formKey,
                                emailController: emailController,
                                subjectController: subjectController,
                                previewController: previewController,
                                nameController: nameController,
                                isToggle1: isToggle1,
                                isToggle2: isToggle2,
                              );
                              clearForm(
                                  nameController: nameController,
                                  emailController: emailController,
                                  previewController: previewController,
                                  subjectController: subjectController);
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

