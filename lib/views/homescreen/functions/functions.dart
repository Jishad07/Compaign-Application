import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/step_provider.dart';
import '../../../utils/steplist_constant.dart';

Future<void> saveFormDraft(
    {required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController subjectController,
    required TextEditingController previewController,
    required bool isToggle1,
    required bool isToggle2}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('name', subjectController.text);
  prefs.setString('email', previewController.text);
  prefs.setString('field1', nameController.text);
  prefs.setString('field2', emailController.text);
  prefs.setBool('toggle1', isToggle1);
  prefs.setBool('toggle2', isToggle2);

  print('Form saved to draft!');
}

Future<void> loadFormData({
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController subjectController,
  required TextEditingController previewController,
  required WidgetRef ref, 
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  nameController.text = prefs.getString('name') ?? '';
  emailController.text = prefs.getString('email') ?? '';
  subjectController.text = prefs.getString('subject') ?? '';
  previewController.text = prefs.getString('previewText') ?? '';

  ref.read(toggle1Provider.state).state =
      prefs.getBool('runOncePerCustomer') ?? false;
  ref.read(toggle2Provider.state).state =
      prefs.getBool('customAudience') ?? false;

  print("Form data loaded from SharedPreferences");
}

void _submitForm(
    {required nameController,
    required emailController,
    required previewController,
    required subjectController,
    required isToggle1,
    required isToggle2,
    required GlobalKey<FormState> formKey,
    required BuildContext context}) {
  if (formKey.currentState?.validate() ?? false) {
    submitForm(
        ref: WidgetRef,
        nameController: nameController,
        emailController: emailController,
        previewController: previewController,
        subjectController: subjectController,
        isToggle1: isToggle1,
        isToggle2: isToggle2,
        formKey: formKey,
        context: context);
  }
}

void submitForm({
  required nameController,
  required emailController,
  required previewController,
  required subjectController,
  required isToggle1,
  required isToggle2,
  required GlobalKey<FormState> formKey,
  required BuildContext context,
  required Type ref,
  //  required ref ,
}) {
  if (formKey.currentState?.validate() ?? false) {
    String name = nameController.text;
    String email = emailController.text;
    String field1 = subjectController.text;
    String field2 = previewController.text;
    bool toggle1 = isToggle1;
    bool toggle2 = isToggle2;

    print("submit alertbox called");

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Form Submitted!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text('Name: $name', style: const TextStyle(fontSize: 16)),
                      Text('Email: $email',
                          style: const TextStyle(fontSize: 16)),
                      Text('Subject: $field1',
                          style: const TextStyle(fontSize: 16)),
                      Text('preview: $field2',
                          style: const TextStyle(fontSize: 16)),
                      Text('Run only once per customer: $toggle1',
                          style: const TextStyle(fontSize: 16)),
                      Text('Custom audience: $toggle2',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    print("submit button not called");
  }
}

void nextStep({
  required BuildContext context,
  required ref,
  required GlobalKey<FormState> formKey,
}) {
  if (formKey.currentState?.validate() ?? false) {
    final currentStep = ref.read(currentStepProvider.state).state;
    if (currentStep < steps.length - 1) {
      ref.read(currentStepProvider.state).state++;
    }
  }
}

void clearForm({
  required nameController,
  required emailController,
  required previewController,
  required subjectController,
}) {
  nameController.clear();
  emailController.clear();
  subjectController.clear();
  previewController.clear();
}

void resetToggles({required ref}) {
  ref.read(toggle1Provider.state).state = false;
  ref.read(toggle2Provider.state).state = false;
}
