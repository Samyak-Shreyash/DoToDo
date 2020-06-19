import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotodo/models/task.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  String taskId;
  var uuid = Uuid();

  DatabaseService({this.uid});

  CollectionReference get taskCollection => getCollection('task');

  Future updateUserData(
      String taskName, String priority, String category) async {
    taskId = taskId ?? uuid.v1();
    print(taskId);
    return await taskCollection.document().setData({
//      'user_id': uid,
//      'task_id': taskId,
      'title': taskName,
      'priority': priority,
      'category': category,
    });
  }

  CollectionReference getCollection(String s) {
    print(uid);
    return Firestore.instance.collection('task_$uid');
      
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshots) {
    print(snapshots);
    return snapshots.documents.map((doc){
//      print('Document ID : ${doc.documentID}');
      return Task(
//        id: doc.documentID??uuid.v1(),
        title: doc.data['title']??'',
        priority: doc.data['priority']??'low',
        category: doc.data['category']??'task'
      );
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots()
    .map(_taskListFromSnapshot);
  }

  }
