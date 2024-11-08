

class StepModel {
  final String title;
  final String subtitle;

  StepModel({required this.title, required this.subtitle});

 
  Map<String, String> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}
