import 'dart:convert';

import 'package:flutter_firebase/features/models/admin_signup_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  static String keyToken = 'token';
  static String keyEmail = 'email';
  static String keyUserName = 'username';
  static String keyFirstName = 'firstName';
  static String keyLastName = 'lastName';
  static String keyTenantId = 'tenantId';
  static String keyUIId = 'keyUIId';
  static String currentUser = 'currentUser';

  //
  // Future setUserName(String username) async {
  //   await storage.write(key: _keyUserName, value: username);
  // }
  //
  // Future<String?> getUserName() async {
  //   return await storage.read(key: _keyUserName);
  // }

  Future setKeyValue({required String key, required dynamic value}) async {
    await storage.write(key: key, value: value);
  }

  Future getValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future clearStorage() async {
    await storage.deleteAll();
  }

  /*-------------*/
  Future saveCurrentUserDetails(String value) async {
    await storage.write(key: currentUser, value: value);
  }

  Future<UserModel> getCurrentUserDetails() async {
    String currentUserDataInString =
        await storage.read(key: currentUser) as String;
    Map<String, dynamic> myMap = jsonDecode(currentUserDataInString);
    UserModel userModel = UserModel.fromMap(myMap, '');
    return userModel;
  }
}
