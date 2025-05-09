import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, UserCredential, User;
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/core/fire_store_database/firestore_path.dart';
import 'package:flutter_firebase/core/token_manager/token_manager.dart';
import 'package:flutter_firebase/features/repository/authentication_repo.dart';

import '../../core/fire_store_database/firestore_db.dart'
    show FireStoreDatabase;
import '../models/admin_signup_model.dart' show SignUpModel;

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

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.sendEmailVerification();
    }

    var tenantPath = FireStorePath.tenant();
    var adminUserPath = FireStorePath.adminUsers();
    var tenantId = 'ebay';
    SignUpModel model = SignUpModel();
    model.firstName = '';
    model.lastName = '';
    model.email = email;
    model.uuId = user.user!.uid;
    model.tenantId = tenantId;
    var path = '$tenantPath/$tenantId/$adminUserPath';
    debugPrint('path: $path');
    await database.addAdmin(model.toMap(), path, model.uuId);
   // await database.addAdminInTenant(tenantPath, tenantId, model.uuId);
    return true;
  }

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await TokenManager().saveToken();
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
