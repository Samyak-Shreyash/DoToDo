import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotodo/models/task.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String id;
  final String parentID;

  DatabaseService({this.id, this.parentID});

  //Collection reference
  CollectionReference get taskCollection => collectionReferenceName("task");

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task.fromJson(doc.data, doc.documentID);
    }).toList();
  }

  Future updateUserData(Task task) async {
    print(task.id);
    DocumentReference refPath= task.id==null?taskCollection.document():taskCollection.document(task.id);
    print(refPath);
    try {
      await refPath.setData(task.toJson());
    }
    catch (e) {
      print(e);
    }

  }

  Future deleteTask(String id) async {
    String _docID = id;
    try {
      await taskCollection.document(_docID).delete();
    } catch (e) {
      debugPrint(e);
    }
  }

  Stream<List<Task>> get tasks {
    return taskCollection
        .where('parentID', isEqualTo: parentID)
        .snapshots()
        .map(_taskListFromSnapshot);
  }

  CollectionReference collectionReferenceName(String prefix) {
    String collectionName = "$prefix" + "_" + id;
    return Firestore.instance.collection(collectionName);
  }
}
