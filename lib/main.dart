import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vancouver_open_data/controller/api_controller.dart';
import 'view/home/home_screen.dart';

void main() async{
  Get.put(ApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController().fetchFountainData();
    return GetMaterialApp(
      title: 'Vancouver Open Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );
  }
}
