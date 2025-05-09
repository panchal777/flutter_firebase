import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/router/router_name.dart';
import 'package:flutter_firebase/core/utils/app_string.dart';
import 'package:flutter_firebase/core/widgets/round_button.dart'
    show RoundButton;
import 'package:flutter_firebase/features/view_models/authentication_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerState, ConsumerStatefulWidget;
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/common.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
      // if (prev != next) {
      if (next.stateModel.msg.isNotEmpty) {
        Common.toastMessage(
          next.stateModel.msg,
          isError: next.stateModel.isError,
        );
      }
      if (next.stateModel.isSuccess) {
        context.go(RouteName.dashboard);
      }
      // }
    });

    return PopScope(
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(AppString.loginTitle)),
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
                  title: AppString.loginTitle,
                  loading: viewModel.stateModel.showProgress,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(AppString.forgotPasswordTitle),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppString.doNotHaveAnAccount),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(RouteName.signUp);
                      },
                      child: Text(AppString.signUp),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(child: Text(AppString.loginWithPhone)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    viewModel.signInWithEmailAndPassword(
      emailController.text,
      passwordController.text,
    );
  }
}
