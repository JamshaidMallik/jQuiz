import 'package:html_unescape/html_unescape.dart';
final unescape = HtmlUnescape();


class Question {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;

  Question({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    List<String> answers = List<String>.from(map['incorrect_answers'])
        .map((ans) => unescape.convert(ans))
        .toList();

    final correct = unescape.convert(map['correct_answer']);
    answers.add(correct);
    answers.shuffle();

    return Question(
      type: map['type'],
      difficulty: map['difficulty'],
      category: map['category'],
      question: unescape.convert(map['question']),
      correctAnswer: map['correct_answer'],
      allAnswers: answers,
    );
  }
}