

class FormState {
  final String name;
  final String email;
  final String field1;
  final String field2;
  final bool isToggle1;
  final bool isToggle2;
  final int currentStep;

  FormState({
    required this.name,
    required this.email,
    required this.field1,
    required this.field2,
    required this.isToggle1,
    required this.isToggle2,
    required this.currentStep,
  });

  FormState copyWith({
    String? name,
    String? email,
    String? field1,
    String? field2,
    bool? isToggle1,
    bool? isToggle2,
    int? currentStep,
  }) {
    return FormState(
      name: name ?? this.name,
      email: email ?? this.email,
      field1: field1 ?? this.field1,
      field2: field2 ?? this.field2,
      isToggle1: isToggle1 ?? this.isToggle1,
      isToggle2: isToggle2 ?? this.isToggle2,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

