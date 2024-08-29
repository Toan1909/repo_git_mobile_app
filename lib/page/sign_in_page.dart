import 'package:assign01/network/github_api.dart';
import 'package:assign01/page/intro_page.dart';
import 'package:assign01/page/sign_up_page.dart';
import 'package:assign01/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../shared/spref.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailSignInCtl = TextEditingController();
  final TextEditingController passSignInCtl = TextEditingController();
  bool _onLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                child: TextFormField(
                  validator: ValidationBuilder().email("Invalid email ").maxLength(50,'Email require less than 50 characters').build(),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: "Email",
                      border: OutlineInputBorder()),
                  controller: emailSignInCtl,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                child: TextFormField(
                  validator: ValidationBuilder().minLength(4,"Name require greater than 4 characters").maxLength(32,"Name require less than 32 characters").build(),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
                      hintText: "Password",
                      border: OutlineInputBorder()),
                  controller: passSignInCtl,
                ),
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
                  onPressed: _onBtnSignInPressed,
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: const Text(
                    "Don't have account? Sign up now!",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ))
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

  void _onBtnSignInPressed() {
    setState(() {
      _onLoading = true;
    });
    var email = emailSignInCtl.text;
    var pass = passSignInCtl.text;
    GithubApi().signIn(email, pass).then((user) async {
      await SPref.instance.set("token", user.token);
      setState(() {
        Future.delayed(const Duration(seconds: 1));
        _onLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const IntroPage()));
    }).catchError((e) {
      setState(() {
        _onLoading = false;
      });
      // Kiểm tra lỗi và hiển thị thông báo phù hợp
      String errorMessage = "";
      if (e == "Unauthorized") {
        errorMessage = "Lỗi xác thực tài khoản, kiểm tra email hoặc passwork";
      } else {
        errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
      }
      // Hiển thị thông báo lỗi cho người dùng
      myDialog(
          context: context, title: "Sign In Error :((", message: errorMessage);
    });
  }
}
