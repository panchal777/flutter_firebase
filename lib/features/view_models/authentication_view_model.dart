import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/features/models/state_model.dart';
import 'package:flutter_firebase/features/repository/authentication_repo.dart';
import 'package:flutter_firebase/features/view_models/repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationViewModel extends ChangeNotifier {
  final AuthenticationRepo repo;

  StateModel stateModel = StateModel();

  AuthenticationViewModel({required this.repo});

  Future<dynamic> signUp(String email, String password) async {
    try {
      notifyStates(showProgress: true);
      var isUserCreated = await repo.signUpWithEmailAndPassword(
        email,
        password,
      );
      if (isUserCreated) {
        notifyStates(isSuccess: true, msg: 'User created successfully');
      }
    } catch (e) {
      notifyStates(isError: true, msg: e.toString());
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      notifyStates(showProgress: true);
      var isUserLoggedIn = await repo.loginWithEmailAndPassword(
        email,
        password,
      );
      if (isUserLoggedIn) {
        notifyStates(isSuccess: true, msg: 'User sign in successfully');
      }
    } catch (e) {
      notifyStates(isError: true, msg: e.toString());
    }
  }

  notifyStates({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    bool? showProgress,
    String? msg,
  }) {
    setDefaultToFalse();
    stateModel.isLoading = isLoading ?? stateModel.isLoading;
    stateModel.isError = isError ?? stateModel.isError;
    stateModel.isSuccess = isSuccess ?? stateModel.isSuccess;
    stateModel.showProgress = showProgress ?? stateModel.showProgress;
    stateModel.msg = msg ?? stateModel.msg;
    notifyListeners();
  }

  setDefaultToFalse() {
    stateModel = StateModel();
    //notifyListeners();
  }
}

final authenticationViewModelProvider =
    ChangeNotifierProvider.autoDispose<AuthenticationViewModel>((ref) {
      final authenticationRepo = ref.watch(authenticationRepoProvider);
      return AuthenticationViewModel(repo: authenticationRepo);
    });
