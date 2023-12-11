import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/ui/_widget/custom_bottom_screen.dart';
import 'package:food_app/ui/_widget/custom_textfield.dart';
import 'package:food_app/ui/cubit/sign_in_cubit.dart';
import 'package:food_app/ui/views/home_view.dart';
import 'package:food_app/ui/views/navbar_view.dart';
import 'package:food_app/ui/views/onboard_view.dart';
import 'package:food_app/ui/views/signup_view.dart';
import 'package:food_app/utility/valid_email.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _email = '';

  String _password = '';

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
                  signInForm(),
                  custombottomScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column signInForm() {
    return Column(
      children: [
        emailField(),
        passwordField(),
      ],
    );
  }

  Padding emailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextField(
        icon: Icons.email,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          _email = value;
        },
        text: 'E-Posta',
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CustomTextField(
        icon: Icons.lock,
        isPassword: true,
        onChanged: (value) {
          _password = value;
        },
        text: 'Şifre',
      ),
    );
  }

  Column custombottomScreen() {
    return Column(
      children: [
        BlocBuilder<SignInCubit, int>(
          builder: (context, state) {
            if (state == 0) {
              return CustomBottomScreen(
                textButton: 'Giriş Yap',
                question: 'Hesabınız yok mu?',
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_email.isEmpty || _password.isEmpty) {
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
                  } else {
                    var result = await context
                        .read<SignInCubit>()
                        .signIn(_email, _password);

                    if (result != null) {
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavbarView()),
                      );
                    } else {
                      if (!mounted) return;
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text:
                            'Giriş Başarısız Oldu Bilgilerinizi Kontrol Edin.',
                      );
                    }
                  }
                },
                questionPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupView()),
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
