import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotodo/models/task.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  CollectionReference get taskCollection => collectionReferenceName("task");

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
//      debugPrint(doc.documentID);
      return Task(
          id: doc.documentID ?? '',
          title: doc.data['title'] ?? '',
          priority: doc.data['priority'] ?? 'low',
          category: doc.data['category'] ?? 'Task');
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  CollectionReference collectionReferenceName(String prefix) {
//       debugPrint("Prefix: $prefix");
//       debugPrint("Suffix: $uid");
    String collectionName = "$prefix" + "_" + uid;
//       debugPrint("Collection Name: $collectionName");
    return Firestore.instance.collection(collectionName);
  }
}
