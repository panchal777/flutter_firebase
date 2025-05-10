import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_secure_storage/secure_storage.dart';

class TokenService {
  Future<String> saveToken() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? mUser = firebaseAuth.currentUser;
    if (mUser != null) {
      final idToken = await mUser.getIdTokenResult(true);
      final SecureStorage secureStorage = SecureStorage();
      await secureStorage.setKeyValue(
        key: SecureStorage.keyToken,
        value: idToken.token,
      );

      return idToken.token ?? '';
    }
    return '';
  }
}
