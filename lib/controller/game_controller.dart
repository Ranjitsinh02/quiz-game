import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz_game_app/database/db_helper.dart';
import 'package:quiz_game_app/model/questions.dart';
import 'package:quiz_game_app/utils/app_strings.dart';

class GameController extends GetxController {
  var questions = <Question>[].obs;
  RxString userSelectedAnswer = ''.obs;
  RxString resultStatus = ''.obs;
  RxBool attendQuestions = true.obs;
  List<String> optionList = [];
  RxBool gameOver = false.obs;
  var currentQuestionIndex = 0.obs;
  Timer? timer;
  int timerDurationSeconds = 20;
  int timeLeft = 20;
  RxInt totalScore = 0.obs;
  RxInt totalAttendQuestions = 0.obs;
  RxInt correctAnswerCount = 0.obs;
  RxInt questionNumber = 1.obs;
  RxBool resultColorBool = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadQuestions();
    startTimer();
  }

  void startTimer() {
    timeLeft = timerDurationSeconds;
    update();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        timer.cancel();
        nextQuestion();
      } else {
        timeLeft--;
        update();
      }
    });
  }

  Future<void> loadQuestions() async {
    // Load questions from the database and update _questions list
    questions.value = await DBHelper.instance.getQuestions();
    update();
  }

  void cancelTimer() {
    timer?.cancel();
  }

  // Navigate to user one question to another
  void nextQuestion() {
    cancelTimer(); // Cancel the timer before moving to the next question
    attendQuestions.value = true;

    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value =
          (currentQuestionIndex.value + 1) % questions.length;
      update();
      startTimer();
    } else {
      attendQuestions.value = false;
      gameOver.value = true;
      update();
      resultCalculation();
    }
    if (!gameOver.value) {
      questionNumber.value++;
    }
  }

  // User tap on option
  void selectedAnswers(String answer) {
    cancelTimer();
    int score = 0;
    userSelectedAnswer.value = answer;
    update();

    if (userSelectedAnswer.value == questions[currentQuestionIndex.value].correctAnswer) {
      correctAnswerCount.value++; // Calculate the correctAnswerCount
      score = 10 + timeLeft; // Calculate score for correct answer
    } else {
      score = 0; // Answer is not correct
    }

    totalScore = totalScore + score; // Update total score
    update();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        totalAttendQuestions.value++; // Update the total number of attended question
        nextQuestion();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    cancelTimer(); // Cancel the timer when the controller is closed
  }

  // User selected the option only once after click onw option user not change the selected option
  void updateAttendQuestion() {
    attendQuestions.value = false;
  }

  // Show the message that depended on correct answer given by user
  void resultCalculation() {
    switch (correctAnswerCount.value) {
      case 3:
      case 4:
        resultStatus.value = AppStrings.wellPlayedButYouFailed;
        resultColorBool.value = true;
        break;
      case 5:
      case 6:
        resultStatus.value = AppStrings.youWin;
        break;
      case 7:
      case 8:
        resultStatus.value =
            "${AppStrings.youWin} ${AppStrings.congratulations}.";
        break;
      case 9:
        resultStatus.value =
            "${AppStrings.youWin} ${AppStrings.congratulations} and ${AppStrings.wellDone}.";
        break;
      case 10:
        resultStatus.value = AppStrings.gameWin;
        break;
      default:
        resultStatus.value = AppStrings.sorryYouFailed;
        resultColorBool.value = true;
        break;
    }
  }
}
