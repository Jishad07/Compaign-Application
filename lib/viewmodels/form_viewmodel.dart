

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/formdata_model.dart';

class FormNotifier extends StateNotifier<FormState> {
  FormNotifier()
      : super(FormState(
          name: '',
          email: '',
          field1: '',
          field2: '',
          isToggle1: false,
          isToggle2: false,
          currentStep: 0,
        ));

  Future<void> loadFormDraft() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      field1: prefs.getString('field1') ?? '',
      field2: prefs.getString('field2') ?? '',
      isToggle1: prefs.getBool('toggle1') ?? false,
      isToggle2: prefs.getBool('toggle2') ?? false,
    );
  }

  Future<void> saveFormDraft() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', state.name);
    prefs.setString('email', state.email);
    prefs.setString('field1', state.field1);
    prefs.setString('field2', state.field2);
    prefs.setBool('toggle1', state.isToggle1);
    prefs.setBool('toggle2', state.isToggle2);
  }

  void updateFormData({
    String? name,
    String? email,
    String? field1,
    String? field2,
    bool? isToggle1,
    bool? isToggle2,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      email: email ?? state.email,
      field1: field1 ?? state.field1,
      field2: field2 ?? state.field2,
      isToggle1: isToggle1 ?? state.isToggle1,
      isToggle2: isToggle2 ?? state.isToggle2,
    );
  }

  void updateStep(int newStep) {
    state = state.copyWith(currentStep: newStep);
  }
}

final formNotifierProvider =
    StateNotifierProvider<FormNotifier, FormState>((ref) {
  return FormNotifier();
});
