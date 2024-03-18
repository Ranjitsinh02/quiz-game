import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_game_app/controller/InitialScreenController.dart';
import 'package:quiz_game_app/custom_widget/round_circle_widget.dart';
import 'package:quiz_game_app/utils/app_strings.dart';
import 'package:quiz_game_app/view/play_game_screen.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({super.key});

  final controller = Get.put(InitialScreenController());

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          AppStrings.quizApp,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Navigate to GameScreen
            Get.to(() => GameScreen());
          },
          child: const RoundCircleWidget(
            title: AppStrings.playGame,
          ),
        ),
      ),
    ));
  }
}
