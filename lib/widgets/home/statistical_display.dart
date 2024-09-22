import 'package:flutter/material.dart';

import '../../config/styles.dart';

class StatisticsDisplay extends StatelessWidget {
  const StatisticsDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70,
          width: double.infinity,
          color: primaryColor,
        ),
        Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticsColumn(title: "Total", value: "150"),
                  StatisticsColumn(title: "Friendly", value: "75"),
                  StatisticsColumn(title: "In operation", value: "75"),
                  StatisticsColumn(title: "Maintainer", value: "5"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StatisticsColumn extends StatelessWidget {
  final String title;
  final String value;

  const StatisticsColumn({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(title),
      ],
    );
  }
}