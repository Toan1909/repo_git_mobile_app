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
      title: "Repo Github Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RepoGithubDemo",
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
