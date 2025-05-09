import 'package:firebase_auth/firebase_auth.dart';

class TokenManager {
  Future<String> saveToken() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? mUser = firebaseAuth.currentUser;
    if (mUser != null) {
      final idToken = await mUser.getIdTokenResult(true);
      return idToken.token ?? '';
    }
    return '';
  }
}
