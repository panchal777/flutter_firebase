import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreService {
  FireStoreService._();

  static final instance = FireStoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    var doc = FirebaseFirestore.instance.collection(path).doc();
    await doc
        .set(data) //,merge
        .then((_) {
          debugPrint("FireStoreService: set data success -> ${doc.id}");
        });
  }

  Future<void> setDataForUniqueId({
    required documentId,
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    var doc = FirebaseFirestore.instance.collection(path).doc(documentId);
    await doc
        .set(data) //,merge
        .then((_) {
          debugPrint(
            "FireStoreService: set data for unique id success -> ${doc.id}",
          );
        });
  }

  Future<void> updateValue({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance
        .collection(path)
        .doc(documentId)
        .update(data)
        .then((value) {
          debugPrint(
            "FireStoreService: post updated data success -> $documentId",
          );
        });
  }

  Future<void> updateArray({
    required String path,
    required String documentId,
    required List<String> data,
  }) async {
    var ref = FirebaseFirestore.instance.collection(path).doc(documentId);
    ref
        .update({"admins": FieldValue.arrayUnion(data)})
        .then((value) => print("Post Updated"));
  }

  Future<void> deleteTableData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
    debugPrint("FireStoreService: delete table data success -> $path");
  }

  Future<bool> deleteItemFromID({
    required String path,
    required String documentId,
  }) async {
    await FirebaseFirestore.instance
        .collection(path)
        .doc(documentId)
        .delete()
        .then((value) {
          debugPrint("FireStoreService: delete item from id success -> $path");
        });
    return true;
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Object? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    debugPrint("FireStoreService: collection stream: $path");
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs
              .map((snapshot) {
                var source =
                    snapshot.metadata.isFromCache ? "local cache" : "server";
                debugPrint(
                  "FireStoreService: collection stream -> Data came from $source",
                );
                return builder(snapshot.data(), snapshot.id);
              })
              .where((value) => value != null)
              .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<List<String>> distinctListStream<T>({
    required String path,
    required T Function(Object? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    bool? sortDescending,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs
              .map((snapshot) {
                var source =
                    snapshot.metadata.isFromCache ? "local cache" : "server";
                debugPrint(
                  "FireStoreService: distinct list stream -> Data came from $source",
                );
                return builder(snapshot.data(), snapshot.id);
              })
              .where((value) => value != null)
              .map((e) {
                return (e).toString();
              })
              .toSet()
              .toList();
      if (sortDescending != null && sortDescending) {
        result.sort((a, b) => b.toLowerCase().compareTo(a.toLowerCase()));
      } else {
        result.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      }

      return result;
    });
  }

  Stream<PaginationModel> paginationList<T>({
    required String path,
    required T Function(Object? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    List<DocumentSnapshot>? documentSnapShotList,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      if (documentSnapShotList != null) {
        documentSnapShotList = snapshot.docs;
      }
      final result =
          snapshot.docs
              .map((snapshot) => builder(snapshot.data(), snapshot.id))
              .where((value) => value != null)
              .toList();
      if (sort != null) {
        result.sort(sort);
      }
      PaginationModel paginationModel = PaginationModel();
      paginationModel.documentSnapShotList = documentSnapShotList!;
      paginationModel.paginationList = result;
      return paginationModel;
      //return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required String documentId,
    required T Function(Object? data, String documentID) builder,
  }) {
    debugPrint(
      "FireStoreService: document Stream -> path: $path, documentId: $documentId",
    );

    final DocumentReference reference = FirebaseFirestore.instance
        .collection(path)
        .doc(documentId);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    debugPrint(
      "FireStoreService: document stream data success: ${snapshots.length}",
    );
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<T> documentSubCollectionStream<T>({
    required String mainPath,
    required String subPath,
    required String documentId,
    required T Function(Object? data, String documentID) builder,
  }) {
    debugPrint(
      "FireStoreService: documentSubCollectionStream-> mainPath: $mainPath subPath: $subPath, documentId: $documentId",
    );
    final DocumentReference reference = FirebaseFirestore.instance
        .collection(mainPath)
        .doc(documentId)
        .collection(subPath)
        .doc("${documentId}pdf");
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    debugPrint(
      "FireStoreService: documentSubCollectionStream data success: ${snapshots.length}",
    );

    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<void> saveDataInFireStore({
    required Map<String, dynamic> map,
    required String path,
    required String subPath,
  }) async {
    var doc = FirebaseFirestore.instance.collection(path).doc();
    await doc
        .collection(subPath)
        .doc()
        .set(map) //,merge
        .then((_) {
          debugPrint(
            "FireStoreService: saveDataInFireStore success: ${doc.id}",
          );
        });
  }
}

deleteSubCollection({
  required String path,
  required String subCollectionPath,
  required String documentId,
}) async {
  var snapshots =
      FirebaseFirestore.instance
          .collection(path)
          .doc(documentId)
          .collection(subCollectionPath)
          .snapshots();
  await snapshots.forEach((snapShots) {
    if (snapShots.docs.isNotEmpty) {
      for (var element in snapShots.docs) {
        debugPrint(
          "Delete collection for $documentId ----- $subCollectionPath : ${element.id}",
        );
        FirebaseFirestore.instance
            .collection(path)
            .doc(documentId)
            .collection(subCollectionPath)
            .doc(element.id)
            .delete()
            .then((value) {
              // debugPrint("Delete collection for $subCollectionPath : ${element.id}");
            });
      }
    }
  });
  return true;
}

class PaginationModel {
  List<dynamic>? paginationList;
  List<DocumentSnapshot>? documentSnapShotList;

  PaginationModel({this.documentSnapShotList, this.paginationList});
}
