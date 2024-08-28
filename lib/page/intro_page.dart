import 'package:assign01/page/home_page.dart';
import 'package:assign01/page/sign_in_page.dart';
import 'package:assign01/shared/spref.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  _navigation() async {
    var token = await SPref.instance.get("token");
    if (token != null) {
      print("Token :${token.toString()}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _navigation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Image(
            image: AssetImage('assets/logo.png'),
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
