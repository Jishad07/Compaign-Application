import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final currentStepProvider = StateProvider<int>((ref) => 0);

final toggle1Provider = StateProvider<bool>((ref) => false);

final toggle2Provider = StateProvider<bool>((ref) => false);

final formKeyProvider = Provider<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});
