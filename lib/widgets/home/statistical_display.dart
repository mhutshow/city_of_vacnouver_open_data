import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vancouver_open_data/controller/api_controller.dart';

import '../../config/styles.dart';

//As we are using pagination, and the api does not provide statistical data, we will show mock data

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => StatisticsColumn(
                        title: "Total",
                        value: Get.find<ApiController>()
                            .maxDataCount
                            .value
                            .toString()),
                  ),
                  const StatisticsColumn(title: "Pet Friendly", value: "95"),
                  const StatisticsColumn(title: "In operation", value: "175"),
                  const StatisticsColumn(title: "Maintainer", value: "5"),
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
