import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/utils/app_string.dart';
import 'package:flutter_firebase/core/utils/common.dart';

import '../../../../core/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppString.forgotPassword)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: AppString.emailHint),
            ),
            SizedBox(height: 40),
            RoundButton(
              title: AppString.forgot,
              onTap: () {
                auth
                    .sendPasswordResetEmail(
                      email: emailController.text.toString(),
                    )
                    .then((value) {
                      Common.toastMessage(AppString.forgotPasswordSuccessMsg);
                    })
                    .onError((error, stackTrace) {
                      Common.toastMessage(error.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
