class Question {
  final int id;
  final String question;
  final List<Option> options;
  String correctAnswer = '';

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctAnswer});
}

class Option {
  final String optionText;

  Option({required this.optionText});
}

// class Question {
//   final String questionText;
//   final List<Option> options;
//   final String correctOptionIndex;
//
//   Question({required this.questionText, required this.options, required this.correctOptionIndex});
//
//   factory Question.fromJson(Map<String, dynamic> json) {
//     var optionsList = json['options'] as List;
//     List<Option> options = optionsList.map((optionJson) => Option.fromJson(optionJson)).toList();
//     return Question(
//       questionText: json['questionText'],
//       options: options,
//       correctOptionIndex: json['correctOptionIndex'],
//     );
//   }
// }
//
// class Option {
//   final String optionText;
//
//   Option({required this.optionText});
//
//   factory Option.fromJson(Map<String, dynamic> json) {
//     return Option(
//       optionText: json['optionText'],
//     );
//   }
// }
//

//
// class Question1{
//   final int id;
//   final String question;
//   final String correctAnswer;
//   final List<Option> options;
//
//   Question1({
//     required this.id,
//     required this.question,
//     required this.correctAnswer,
//     required this.options,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'question': question,
//       'correct_answer': correctAnswer,
//       'option1': options[0],
//       'option2': options[1],
//       'option3': options[2],
//     };
//   }
//
//   factory Question1.fromMap(Map<String, dynamic> map) {
//     return Question1(
//       id: map['id'],
//       question: map['question'],
//       correctAnswer: map['correct_answer'],
//       options: [map['option1'], map['option2'], map['option3']],
//     );
//   }
// }
//
// class Option {
//   final String optionText;
//
//   Option({required this.optionText});
// }
