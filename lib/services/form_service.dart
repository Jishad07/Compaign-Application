

import 'package:shared_preferences/shared_preferences.dart';
import '../models/formdata_model.dart';

class FormService {
  Future<FormState> loadFormData() async {
    final prefs = await SharedPreferences.getInstance();

    return FormState(
      currentStep: 0,
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      field1: prefs.getString('field1') ?? '',
      field2: prefs.getString('field2') ?? '',
      isToggle1: prefs.getBool('toggle1') ?? false,
      isToggle2: prefs.getBool('toggle2') ?? false,
    );
  }

  Future<void> saveFormData(FormState formData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', formData.name);
    await prefs.setString('email', formData.email);
    await prefs.setString('field1', formData.field1);
    await prefs.setString('field2', formData.field2);
    await prefs.setBool('toggle1', formData.isToggle1);
    await prefs.setBool('toggle2', formData.isToggle2);
  }
}
