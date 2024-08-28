import 'package:assign01/page/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'get/repo_controller.dart';

void main() {
  runApp(const MyApp());
  Get.put(RepoController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Repo Github ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroPage(),
    );
  }
}

