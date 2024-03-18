import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_game_app/model/questions.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'quiz_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  // Create a table for questions and options.
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions(
        id INTEGER PRIMARY KEY,
        question TEXT,
        correctAnswer TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE options(
        id INTEGER PRIMARY KEY,
        questionId INTEGER,
        optionText TEXT,
        FOREIGN KEY (questionId) REFERENCES questions(id)
      )
    ''');
  }

  // Insert the Questions into database
  Future<int> insertQuestion(Question question) async {
    Database db = await database;
    int questionId = await db.insert(
      'questions',
      {'question': question.question, 'correctAnswer': question.correctAnswer},
    );
    await insertOptions(questionId, question.options);
    return questionId;
  }

  // Insert the options using the questionId into database
  Future<void> insertOptions(int questionId, List<Option> options) async {
    Database db = await database;
    Batch batch = db.batch();
    for (Option option in options) {
      batch.insert('options',
          {'questionId': questionId, 'optionText': option.optionText});
    }
    await batch.commit(noResult: true);
  }

  // Fetch the 10 questions random from the database.
  Future<List<Question>> getQuestions() async {
    Database db = await database;

    List<Map<String, dynamic>> questionRows =
        await db.rawQuery('SELECT * FROM questions ORDER BY RANDOM() LIMIT 10');

    List<Question> questions = [];

    bool isCorrectAnswerFilled = false;

    for (Map<String, dynamic> questionRow in questionRows) {

      List<Map<String, dynamic>> optionRows = await db.query('options',
          where: 'questionId = ?', whereArgs: [questionRow['id']]);

      List<Option> options = optionRows
          .map((optionRow) => Option(optionText: optionRow['optionText']))
          .toList();

      // Fetch the correct answer from the database
      String correctOption = questionRow['correctAnswer'] ?? '';

      List<Option> filterOptions = [];

      // Here, Fetch four options but show only 3 options with one correct answer and 2 incorrect answers
      for (int i = 0; i < options.length; i++) {
        if (correctOption == options[i].optionText) {
          filterOptions.add(options[i]);
          isCorrectAnswerFilled = true;
        } else {
          if (isCorrectAnswerFilled == false || filterOptions.length <= 2) {
            if (i != 2) {
              filterOptions.add(options[i]);
            }
          }
        }
      }
      filterOptions.shuffle(); // Shuffle the options to randomize their positions

      // Fetch data pass to question model
      questions.add(Question(
        id: questionRow['id'],
        question: questionRow['question'],
        options: filterOptions,
        correctAnswer: correctOption,
      ));
    }
    return questions;
  }
}
