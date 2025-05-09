import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart';
import 'package:flutter_firebase/core/utils/app_string.dart';
import 'package:flutter_firebase/core/utils/common.dart';
import 'package:flutter_firebase/features/view_models/authentication_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/round_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthenticationViewModel viewModel;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(authenticationViewModelProvider);

    ref.listen<AuthenticationViewModel>(authenticationViewModelProvider, (
      prev,
      next,
    ) {
      if (next.stateModel.msg.isNotEmpty) {
        Common.toastMessage(
          next.stateModel.msg,
          isError: next.stateModel.isError,
        );
      }
      if (next.stateModel.isSuccess) {
        context.go(RouteName.login);
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(AppString.signUp)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: AppString.emailHint,
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.enterValue('email');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: AppString.passwordHint,
                      prefixIcon: Icon(Icons.lock_open),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppString.enterValue('password');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            RoundButton(
              title: AppString.signUp,
              loading: viewModel.stateModel.showProgress,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppString.alreadyHaveAnAccount),
                TextButton(
                  onPressed: () {
                    context.go(RouteName.login);
                  },
                  child: Text(AppString.loginTitle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signUp() {
    viewModel.signUp(emailController.text, passwordController.text);
  }
}
