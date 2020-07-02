import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotodo/models/task.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String uid;
  final String parentID;

  DatabaseService({this.uid, this.parentID});

  //Collection reference
  CollectionReference get taskCollection => collectionReferenceName("task");

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task.fromJson(doc.data,doc.documentID);
    }).toList();
  }

  Future deleteTask(String id) async
  {
    String _docID= id;
    try{
      await taskCollection.document(_docID).delete();
    }
    catch(e)
    {
      debugPrint(e);
    }
  }
  Stream<List<Task>> get tasks {
    return taskCollection
        .where('parentID',isEqualTo: parentID )
        .snapshots().map(_taskListFromSnapshot);
  }


  CollectionReference collectionReferenceName(String prefix) {
    String collectionName = "$prefix" + "_" + uid;
    return Firestore.instance.collection(collectionName);
  }
}
