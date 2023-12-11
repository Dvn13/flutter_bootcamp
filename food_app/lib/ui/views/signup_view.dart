import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/ui/_widget/custom_bottom_screen.dart';

import 'package:food_app/ui/_widget/custom_textfield.dart';
import 'package:food_app/ui/cubit/sign_up_cubit.dart';
import 'package:food_app/ui/views/onboard_view.dart';
import 'package:food_app/ui/views/signIn_view.dart';
import 'package:food_app/utility/valid_email.dart';
import 'package:quickalert/quickalert.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String _email = '';
  String _password = '';
  String _confirmPass = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnboardView()),
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  signUpForm(),
                  custombottomScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column signUpForm() {
    return Column(
      children: [
        emailField(),
        passwordField(),
        rePasswordField(),
      ],
    );
  }

  Padding emailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomTextField(
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            _email = value;
          },
          text: 'E-Posta',
        ),
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomTextField(
          icon: Icons.lock,
          isPassword: true,
          onChanged: (value) {
            _password = value;
          },
          text: 'Şifre',
        ),
      ),
    );
  }

  Padding rePasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: CustomTextField(
          icon: Icons.lock,
          isPassword: true,
          onChanged: (value) {
            _confirmPass = value;
          },
          text: 'Şifre Tekrarı',
        ),
      ),
    );
  }

  Column custombottomScreen() {
    return Column(
      children: [
        BlocBuilder<SignUpCubit, int>(
          builder: (context, state) {
            if (state == 0) {
              return CustomBottomScreen(
                textButton: 'Kayıt Ol',
                question: 'Zaten hesabın varmı?',
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_email.isEmpty ||
                      _password.isEmpty ||
                      _confirmPass.isEmpty) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Lütfen Tüm Alanları Doldurun.',
                    );
                  } else if (!ValidEmail.isValidEmail(_email)) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Lütfen Geçerli Mail Adresi Girin.',
                    );
                  } else if (_confirmPass == _password) {
                    if (_password.length < 6) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text: 'Şifre en az 6 karakterli olmalı.',
                      );
                    } else {
                      var result = await context
                          .read<SignUpCubit>()
                          .signUp(_email, _password);

                      if (result != null) {
                        if (!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInView()),
                        );
                      } else {
                        if (!mounted) return;
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text:
                              'Kayıt Başarısız Oldu Bilgilerinizi Kontrol Edin.',
                        );
                      }
                    }
                  }
                },
                questionPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInView()),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
