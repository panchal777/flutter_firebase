import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'
    show Fluttertoast, Toast, ToastGravity;

import '../fire_store_database/firestore_db.dart';
import '../flutter_secure_storage/secure_storage.dart';
import 'globals.dart';

class Common {
  static void toastMessage(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static saveUserDetails(String uid) async {
    final FireStoreDatabase database = FireStoreDatabase();
    final SecureStorage secureStorage = SecureStorage();
    var userDetails = await database.getUserDetails(uuid: uid);
    await secureStorage.saveCurrentUserDetails(jsonEncode(userDetails.toMap()));
    Globals.currentUserModel = userDetails;
    debugPrint('userDetails: ${userDetails.toMap()}');
  }
}
