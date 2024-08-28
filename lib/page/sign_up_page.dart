import 'package:assign01/network/github_api.dart';
import 'package:assign01/page/sign_in_page.dart';
import 'package:assign01/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../custom_widgets/text_form.dart';
import '../shared/spref.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameSignUpCtl = TextEditingController();
  final TextEditingController emailSignUpCtl = TextEditingController();
  final TextEditingController passSignUpCtl = TextEditingController();
  bool _onLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN UP"),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFormWidget(
                controller: nameSignUpCtl,
                icon: const Icon(Icons.info_outline),
                hint: "Name",
              ),
              MyTextFormWidget(
                controller: emailSignUpCtl,
                icon: const Icon(Icons.email_outlined),
                hint: "Email",
              ),
              MyTextFormWidget(
                controller: passSignUpCtl,
                icon: const Icon(Icons.password_outlined),
                hint: "Password",
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 40),
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
                  ),
                  onPressed: _onBtnSignUpPressed,
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: _onLoading,
            child: Container(
              color: Colors.black.withOpacity(0.05),
              child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.lightBlueAccent.withOpacity(0.6),
                      size: 60)),
            ))
      ]),
    );
  }

  void _onBtnSignUpPressed() {
    setState(() {
      _onLoading = true;
    });
    var name = nameSignUpCtl.text;
    var email = emailSignUpCtl.text;
    var pass = passSignUpCtl.text;
    GithubApi().signUp(email, name, pass).then((user) async {
      await SPref.instance.set("token", user.token);
      setState(() {
        Future.delayed(const Duration(seconds: 1));
        _onLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }).catchError((e) {
      setState(() {
        _onLoading = false;
      });
      // Kiểm tra lỗi và hiển thị thông báo phù hợp
      String errorMessage = "";
      if (e == "Conflict Account") {
        errorMessage = "Email này đã được sử dụng cho tài khoản khác.";
      } else {
        errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
      }
      // Hiển thị thông báo lỗi cho người dùng
      myDialog(
          context: context, title: "Sign Up Error :((", message: errorMessage);
    });
  }
}
