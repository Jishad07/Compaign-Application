import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/formdata_model.dart';
import '../services/form_service.dart';
import '../viewmodels/form_viewmodel.dart';

final formServiceProvider = Provider<FormService>((ref) {
  return FormService();
});

final formViewModelProvider =
    StateNotifierProvider<FormNotifier, FormState>((ref) {
  final formService = ref.read(formServiceProvider);
  return FormNotifier();
});
