import 'package:flutter/material.dart';

class RoundCircleWidget extends StatelessWidget {
  const RoundCircleWidget({
    super.key, required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 7.0,
            spreadRadius: 5.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Center(
          child: Text(title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
    );
  }
}