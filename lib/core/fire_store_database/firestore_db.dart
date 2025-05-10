import 'dart:async';

import 'package:flutter_firebase/core/fire_store_database/firestore_path.dart';
import 'package:flutter_firebase/features/models/admin_signup_model.dart';

import 'firestore_service.dart';

class FireStoreDatabase {
  final _service = FireStoreService.instance;

  addUser(Map<dynamic, dynamic> map, String path, String name) async {
    await _service.setDataForUniqueId(
      path: path,
      data: map as Map<String, dynamic>,
      documentId: name,
    );
  }

  Future<UserModel> getUserDetails({required String uuid}) {
    return _service.documentStream(
      path: FireStorePath.userPath,
      documentId: uuid,
      builder: (data, documentID) => UserModel.fromMap(data as Map, documentID),
    );
  }
}
