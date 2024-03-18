import 'package:get/get.dart';
import 'package:quiz_game_app/model/questions.dart';

import '../database/db_helper.dart';

class InitialScreenController extends GetxController {
  DBHelper dbHelper = DBHelper.instance;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    var questionRecords = await dbHelper.getQuestions();
    if (questionRecords.isEmpty) {
      insetDateToLocalDatabase();
    }
  }

  Future<void> insetDateToLocalDatabase() async {
    for (Question question in questions) {
      await dbHelper.insertQuestion(question);
    }
  }

  List<Question> questions = [
    Question(
        id: 1,
        question: "Who is the Prime Minister of India?",
        options: [
          Option(optionText: "Narendra Modi"),
          Option(optionText: "Rahul Gandhi"),
          Option(optionText: "Manmohan Singh"),
          Option(optionText: "Amit Shah"),
        ],
        correctAnswer: "Narendra Modi"),

    Question(
        id: 2,
        question: "What is the capital of India?",
        options: [
          Option(optionText: "Mumbai"),
          Option(optionText: "Chennai"),
          Option(optionText: "Delhi"),
          Option(optionText: "Ahmedabad"),
        ],
        correctAnswer: "Delhi"),
    Question(
        id: 3,
        question: "What is sum of 15 + 25 ?",
        options: [
          Option(optionText: "5"),
          Option(optionText: "25"),
          Option(optionText: "40"),
          Option(optionText: "None"),
        ],
        correctAnswer: "40"),
    Question(
        id: 4,
        question: "Which one is maximum? 25, 11, 17, 18, 40, 42",
        options: [
          Option(optionText: "11"),
          Option(optionText: "42"),
          Option(optionText: "17"),
          Option(optionText: "None"),
        ],
        correctAnswer: "42"),
    Question(
        id: 5,
        question: "What is the official language of Gujarat",
        options: [
          Option(optionText: "Hindi"),
          Option(optionText: "Gujarati"),
          Option(optionText: "Marathi"),
          Option(optionText: "None"),
        ],
        correctAnswer: "Gujarati"),
    Question(
        id: 6,
        question: "What is multiplication of 12 * 12 ?",
        options: [
          Option(optionText: "124"),
          Option(optionText: "12"),
          Option(optionText: "24"),
          Option(optionText: "None"),
        ],
        correctAnswer: "None"),
    Question(
        id: 7,
        question: "Which state of India has the largest population?",
        options: [
          Option(optionText: "UP"),
          Option(optionText: "Bihar"),
          Option(optionText: "Gujarat"),
          Option(optionText: "Maharashtra"),
        ],
        correctAnswer: "UP"),
    Question(
        id: 8,
        question: "Who is the Home Minister of India?",
        options: [
          Option(optionText: "Amit Shah"),
          Option(optionText: "Rajnath Signh"),
          Option(optionText: "Narendra Modi"),
          Option(optionText: "None"),
        ],
        correctAnswer: "Amit Shah"),
    Question(
        id: 9,
        question: "What is the capital of Gujarat?",
        options: [
          Option(optionText: "Vadodara"),
          Option(optionText: "Ahmedabad"),
          Option(optionText: "Gandhinagar"),
          Option(optionText: "Rajkot"),
        ],
        correctAnswer: "Gandhinagar"),
    Question(
        id: 10,
        question: "Which number will be next in series? 1, 4, 9, 16, 25",
        options: [
          Option(optionText: "21"),
          Option(optionText: "36"),
          Option(optionText: "49"),
          Option(optionText: "32"),
        ],
        correctAnswer: "36"),
    Question(
        id: 11,
        question: "Which one is minimum? 5, 0, -20, 11",
        options: [
          Option(optionText: "0"),
          Option(optionText: "11"),
          Option(optionText: "-20"),
          Option(optionText: "None"),
        ],
        correctAnswer: "-20"),
    Question(
        id: 12,
        question: "What is sum of 10, 12 and 15?",
        options: [
          Option(optionText: "37"),
          Option(optionText: "25"),
          Option(optionText: "10"),
          Option(optionText: "12"),
        ],
        correctAnswer: "37"),
    Question(
        id: 13,
        question: "What is the official language of the Government of India?",
        options: [
          Option(optionText: "Hindi"),
          Option(optionText: "English"),
          Option(optionText: "Gujarati"),
          Option(optionText: "None"),
        ],
        correctAnswer: "Hindi"),
    Question(
        id: 14,
        question: "Which country is located in Asia?",
        options: [
          Option(optionText: "India"),
          Option(optionText: "USA"),
          Option(optionText: "UK"),
          Option(optionText: "None"),
        ],
        correctAnswer: "India"),
    Question(
        id: 15,
        question: "Which language(s) is/are used for Android app development?",
        options: [
          Option(optionText: "Java"),
          Option(optionText: "Java & Kotlin"),
          Option(optionText: "Kotlin"),
          Option(optionText: "Swift"),
        ],
        correctAnswer: "Java & Kotlin")
    // Add more questions here...
  ];
}
