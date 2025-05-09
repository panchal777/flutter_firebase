import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'
    show Fluttertoast, Toast, ToastGravity;

import '../fire_store_database/firestore_path.dart';

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

  // tenants/ebay/admin_user/[id]
  static String dbBasePath = '${FireStorePath.tenant()}/${'ebay'}';
}
