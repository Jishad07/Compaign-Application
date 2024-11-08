




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

import '../../widgets/mobile_form_widget.dart';
import '../../widgets/web_form_widget.dart';
import 'functions/functions.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final previewController = TextEditingController();

  int _currentStep = 0; // Track the current step
  bool _isToggle1 = false;
  bool _isToggle2 = false;

  @override
  void initState() {
    super.initState();
    _loadFormDraft();
  }

  Future<void> _loadFormDraft() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      subjectController.text = prefs.getString('field1') ?? '';
      previewController.text = prefs.getString('field2') ?? '';
      _isToggle1 = prefs.getBool('toggle1') ?? false;
      _isToggle2 = prefs.getBool('toggle2') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return isMobile
              ? MobileFormWidget(
                  formkey: formKey,
                  nameController: nameController,
                  emailController: emailController,
                  subjectController: subjectController,
                  previewController: previewController)
              : WebFormWidget(
                  formkey: formKey,
                  nameController: nameController,
                  emailController: emailController,
                  subjectController: subjectController,
                  previewController: previewController);
        },
      ),
    );
  }
}



