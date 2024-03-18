import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_game_app/controller/game_controller.dart';
import 'package:quiz_game_app/view/initial_screen.dart';

import '../custom_widget/round_circle_widget.dart';
import '../utils/app_strings.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.message, required this.isColorBool});

  final String message;
  final bool isColorBool;
  final controller = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Center(
                        child: Text(
                      message,
                      style: TextStyle(
                          color: !isColorBool ? Colors.green : Colors.red,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                    Text(
                      "${AppStrings.youGave} ${controller.correctAnswerCount.value} ${AppStrings.correctAnswerOutOf10}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: InkWell(
                            onTap: () {
                              Get.offAll(() => InitialScreen());
                            },
                            child: const RoundCircleWidget(
                              title: AppStrings.startAgain,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
