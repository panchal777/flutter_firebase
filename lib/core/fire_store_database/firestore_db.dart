import 'firestore_path.dart' show FireStorePath;
import 'firestore_service.dart';

class FireStoreDatabase {
  final _service = FireStoreService.instance;

  addAdmin(Map<dynamic, dynamic> map, String path, String name) async {
    await _service.setDataForUniqueId(
      path: path,
      data: map as Map<String, dynamic>,
      documentId: name,
    );
  }

  addAdminInTenant(String path, String id, String uuId) async {
    List<String> users = [];
    users.add(uuId);
    await _service.updateArray(
      path: FireStorePath.tenant(),
      documentId: id,
      data: users,
    );
  }
}
