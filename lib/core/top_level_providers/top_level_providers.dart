import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;

import '../fire_store_database/firestore_db.dart' show FireStoreDatabase;

final databaseProvider = Provider.autoDispose<FireStoreDatabase>((ref) {
  return FireStoreDatabase();
});
