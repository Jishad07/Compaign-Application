// lib/models/step_model.dart

class StepModel {
  final String title;
  final String subtitle;

  StepModel({required this.title, required this.subtitle});

  // Optionally, you can add a method to convert the model to a map if you need to save it as JSON
  Map<String, String> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}
