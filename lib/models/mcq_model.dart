class MCQ {
  final String question;
  final List<String> options;

  MCQ({
    required this.question,
    required this.options,
  });

  factory MCQ.fromJson(Map<String, dynamic> json) {
    return MCQ(
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }
}
