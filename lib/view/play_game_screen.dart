import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_game_app/controller/game_controller.dart';
import 'package:quiz_game_app/custom_widget/elevated_widget.dart';
import 'package:quiz_game_app/utils/app_strings.dart';
import 'package:quiz_game_app/view/result_screen.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  final controller = Get.put(GameController()); // Initialized the GameController using GetX and inject it into the widget tree

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GetBuilder function responsible for update when the totalScore variable change/update the it's value
                GetBuilder<GameController>(
                  builder: (controller) {
                    return Text(
                        "${AppStrings.score} :${controller.totalScore.value}");
                  },
                ),
                // GetBuilder function responsible for update when the timeLeft variable change/update the it's value every time.
                GetBuilder<GameController>(
                  builder: (controller) {
                    return Text(
                      '${AppStrings.timeRemaining} ${controller.timeLeft} ${AppStrings.seconds}',
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => controller.questions.length > 0 // Loading the Question and Options from the database if Question length < 0 then ProgressBar show other wise Question is show
                ? Obx(() => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.questionNumber.value}) ${controller.questions[controller.currentQuestionIndex.value].question}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Obx(() => Column(
                                    children: controller
                                        .questions[controller
                                            .currentQuestionIndex.value]
                                        .options
                                        .map((option) {
                                      return RadioListTile<String>(
                                        title:
                                            Text(option.optionText.toString()),
                                        value: option.optionText.toString(),
                                        groupValue: controller.userSelectedAnswer.value,
                                        onChanged: (value) {
                                          if (controller.attendQuestions.value) {
                                            controller.selectedAnswers(value as String);
                                          }
                                          controller.updateAttendQuestion();
                                        },
                                        tileColor: controller.userSelectedAnswer.value ==
                                                    controller.questions[controller.currentQuestionIndex.value]
                                                        .correctAnswer &&
                                                controller.userSelectedAnswer.value == option.optionText
                                            ? Colors.green
                                            : controller.userSelectedAnswer.value == option.optionText
                                                ? Colors.red
                                                : null,
                                      );
                                    }).toList(),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ))
                : const Center(child: CircularProgressIndicator())),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<GameController>(
                  builder: (controller) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedWidget(
                        title: controller.gameOver.value
                            ? AppStrings.submit
                            : AppStrings.next,
                        color: Colors.white,
                        backgroundColor: controller.gameOver.value
                            ? Colors.green
                            : Colors.black,
                        onPressed: () {
                          if (controller.gameOver.value) {
                            Get.to(() => ResultScreen(
                                  message: controller.resultStatus.value,
                                  isColorBool: controller.resultColorBool.value,
                                ));
                          } else {
                            controller.nextQuestion();
                          }
                        },
                      ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
