
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/utils/logger.dart';

class FirestoreService{
  final _logger = Logger("FirestoreService");
  late CollectionReference _collection;
  String _collectionName="";

  FirestoreService(this._collectionName){
    _collection = FirebaseFirestore.instance.collection(_collectionName);
  }

  Future<bool> setDoc(String docId, Map<String,dynamic> jsonDoc)async{
    try{
      await _collection.doc(docId).set(
        jsonDoc,
        SetOptions(merge: true)
      );
      return true;
    }catch(e,s){
      _logger.error("insertDoc", error: e,stackTrace: s);
    } 
    return false;
  }

  Future<bool> updateDoc(String docId, Map<String,dynamic> data)async{
    try{
      await _collection.doc(docId).update(
        data
      );
      return true;
    }catch(e,s){
      _logger.error("updateDoc", error: e,stackTrace: s);
    } 
    return false;
  }

  Future<DocumentSnapshot?> getDoc(String docId)async{
    try{
      final docSnapshot = await _collection.doc(docId).get();
      if(docSnapshot.exists){
        return docSnapshot;
      }
    }catch(e,s){
      _logger.error("getDoc", error: e,stackTrace: s);
    } 
    return null;
  }

  Future<List<DocumentSnapshot>?> getDocs({
    int limit=5
  })async{
    try{
      final querySnapshot = await _collection.limit(limit).get();
      return querySnapshot.docs;
    }catch(e,s){
      _logger.error("getDocs", error: e,stackTrace: s);
    } 
    return null;
  }

  Future<List<DocumentSnapshot>?> getSpecificDocs(List<String> docIds)async{
    try{
      final querySnapshot = await _collection
        .where(FieldPath.documentId, whereIn: docIds)
        .get();
      return querySnapshot.docs;
    }catch(e,s){
      _logger.error("getDocs", error: e,stackTrace: s);
    } 
    return null;
  }

  Future<List<DocumentSnapshot>?> getDocsWithCondition(
    Object field, {
      Object? isEqualTo,
      Object? isNotEqualTo,
      Object? isLessThan,
      Object? isLessThanOrEqualTo,
      Object? isGreaterThan,
      Object? isGreaterThanOrEqualTo,
      Object? arrayContains,
      Iterable<Object?>? arrayContainsAny,
      Iterable<Object?>? whereIn,
      Iterable<Object?>? whereNotIn,
      bool? isNull,
    }
  )async{
    try{
      final querySnapshot = await _collection
        .where(
          field,
          isEqualTo : isEqualTo
        )
        .get();
      return querySnapshot.docs;
    }catch(e,s){
      _logger.error("getDocs", error: e,stackTrace: s);
    } 
    return null;
  }

  

  String getRandomDocId(){
    return _collection.doc().id;
  }
}
