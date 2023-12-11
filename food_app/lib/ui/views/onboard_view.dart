import 'package:flutter/material.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/ui/_widget/custom_button.dart';
import 'package:food_app/ui/views/signIn_view.dart';
import 'package:food_app/ui/views/signup_view.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [imageWidget(), bodyWidget(context)],
          ),
        ),
      ),
    );
  }

  Expanded imageWidget() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/home.png'),
          ),
        ),
      ),
    );
  }

  Expanded bodyWidget(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            welcomeText(),
            const SizedBox(
              height: 15,
            ),
            loginButton(context),
            const SizedBox(
              height: 10,
            ),
            signupButton(context),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Text welcomeText() {
    return const Text(
      'Yemek Uygulamasına Hoşgeldiniz.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ConstColor.grey,
        fontSize: 20,
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return CustomButton(
      buttonText: 'Giriş Yap',
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInView()),
        );
      },
    );
  }

  Widget signupButton(BuildContext context) {
    return CustomButton(
      buttonText: 'Kayıt Ol',
      isOutlined: true,
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupView()),
        );
      },
    );
  }
}
