import 'package:ajwa_resturant/provider/circular_provider.dart';
import 'package:ajwa_resturant/widgets/colors.dart';
import 'package:ajwa_resturant/widgets/exc_button.dart';
import 'package:ajwa_resturant/widgets/input_text.dart';
import 'package:ajwa_resturant/widgets/sidebar.dart';
import 'package:ajwa_resturant/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailControler = TextEditingController();
    TextEditingController pass = TextEditingController();

    return Container(
      color: AppColors.neutral,
      width: 448,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/logo.svg",
            width: 90,
            height: 55.5,
          ),
          const SizedBox(height: 30),
          const Text(
            "Log in",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
          ),
          const SizedBox(height: 41),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: emailControler,
            labelText: "example@gmail.com",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: pass,
            labelText: "********",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: true,
            enabled: true,
            suffixIcon: visibilityToggle(togglePasswordVisibility, true),
          ),
          const SizedBox(height: 40),
          WonsButton(
            height: 50,
            width: 348,
            verticalPadding: 0,
            color: AppColors.primary,
            child: const Text(
              "Log in",
              style: TextStyle(
                  color: AppColors.neutral,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection("resturant")
                    .get()
                    .then((QuerySnapshot snapshot) {
                  print("sad");
                  snapshot.docs.forEach((element) {
                    if (element['password'] == pass.text &&
                        element['email'] == emailControler.text) {
                      if (emailControler.text.isEmpty || pass.text.isEmpty) {
                        Customdialog().showInSnackBar(
                            "Email and Password is needed", context);
                      } else {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailControler.text,
                          password: pass.text,
                        )
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => SideDrawer()),
                              (route) => false);
                        });
                      }
                    } else {
                      Customdialog().showInSnackBar("wrong", context);
                    }
                  });
                });
              } catch (e) {
                Customdialog().showInSnackBar(e.toString(), context);
              }
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  togglePasswordVisibility() {}
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText(
                'Welcome To',
                textStyle: const TextStyle(
                  fontSize: 82.0,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          )),
          Center(
              child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                'Ajwa Resturant Panel',
                textStyle: const TextStyle(
                  letterSpacing: 1,
                  fontSize: 62.0,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          )),
        ],
      ),
    );
  }
}
