import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, UserCredential, User;
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/core/fire_store_database/firestore_path.dart';
import 'package:flutter_firebase/core/token_service/token_service.dart';
import 'package:flutter_firebase/core/utils/common.dart';
import 'package:flutter_firebase/features/repository/authentication_repo.dart';
import '../../core/fire_store_database/firestore_db.dart'
    show FireStoreDatabase;
import '../models/admin_signup_model.dart' show UserModel;

class AuthenticationRepoImpl extends AuthenticationRepo {
  final FireStoreDatabase database;

  AuthenticationRepoImpl({required this.database});

  @override
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // if (currentUser != null) {
    //   await currentUser.sendEmailVerification();
    // }
    var tenantPath = FireStorePath.tenant;
    var userPath = FireStorePath.users;
    var tenantID = FireStorePath.tenantId;
    UserModel model = UserModel();
    model.firstName = '';
    model.lastName = '';
    model.email = email;
    model.uuId = user.user!.uid;
    model.tenantId = tenantID;
    var path = '$tenantPath/$tenantID/$userPath';
    debugPrint('path: $path');
    await database.addUser(model.toMap(), path, model.uuId);
    return true;
  }

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await TokenService().saveToken();
    await Common.saveUserDetails(user.user!.uid);
    return true;
  }

  @override
  Future loginInWithMobile(String mobile) {
    // TODO: implement signInWithMobile
    throw UnimplementedError();
  }

  @override
  Future verifyOtpForSignIn(String verifyId, String otp) {
    // TODO: implement verifyOtpForSignIn
    throw UnimplementedError();
  }

  @override
  Future forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future changePassword(String email, String password) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
}
