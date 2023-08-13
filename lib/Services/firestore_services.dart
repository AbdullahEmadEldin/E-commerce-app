import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///this service created with Singleton design pattern
///which is simply:
///1- make the constructor private
///2- initialize an object inside the class
///and this object will be the only gate to access the methods of this class

class FirestoreServices {
  FirestoreServices._();
  static final instance = FirestoreServices._();

//careate instance from firestore to use it inside methods
  final _firestore = FirebaseFirestore.instance;
  Future<void> setData({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(documentPath);
    debugPrint('Request data: $data');
    await reference.set(data);
  }

  Future<void> deleteData({required String documentPath}) async {
    final reference = _firestore.doc(documentPath);
    debugPrint('Path: $documentPath');
    await reference.delete();
  }

  Stream<T> documentsStream<T>({
    required String documentPath,

    ///this function won't be implemented here, but will be implemented in DataModel => fromMap() method
    ///it will be specific for each data Model you want to fetch from firestore
    /// Let's say that data will come in JSON format and this function will extract each field from that JSON
    required T Function(Map<String, dynamic>? data, String documentID)
        deMapping,
  }) {
    final reference = _firestore.doc(documentPath);

    ///this Stream of Doucument and this document carry fields of data
    ///Field is Map<String, dynamic> which is accessed by data() method
    final streamSnapshots = reference.snapshots();

    ///def: map() method change the form of each event of the comming document
    ///each doc (Map) comming from stream => will be passed to deMapping function to change it's form!
    return streamSnapshots.map((doc) => deMapping(doc.data(), doc.id));
  }

  //TODO: this function isn't clear enough for me
  Stream<List<T>> collectionsStream<T>({
    required String collectionPath,
    required T Function(Map<String, dynamic>? data, String documentID)
        deMapping,

    ///this function called if you want to query or filter the docs of the collection
    ///this function takes Qury as paramter and return Query output
    ///this function is the process that will be acted on data
    Query Function(Query query)? queryPeocess,
    int Function(T lhs, T rhs)? sort,
  }) {
    ///this query is the structre that you will perform queries on it
    Query query = _firestore.collection(collectionPath);
    if (queryPeocess != null) {
      ///this condition means that if you passed queryProcess to that function
      /// so, make that process on that query
      query = queryPeocess(query);
    }

    /// Why I creatd an object of QuerySnapshot ? ==> because it contain data retrieved from database
    /// and it include methods to access and manipluate data as iterating over the docs (map method)
    final querysnapshotsStream = query.snapshots();

    return querysnapshotsStream.map((querySnapshot) {
      final result = querySnapshot.docs
          .map((docSanpshot) => deMapping(
              docSanpshot.data() as Map<String, dynamic>, docSanpshot.id))
          .where((value) => value != null)
          .toList();
      // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      if (sort != null) result.sort(sort);
      return result;
    });
  }
}
