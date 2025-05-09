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
}
