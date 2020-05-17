import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotodo/models/task.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String uid;
  String taskId;
  var uuid = Uuid();

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference taskCollection =
      Firestore.instance.collection('tasks');

  Future updateUserData(String taskName, int priority, int progress) async {
    taskId:
    taskId ?? uuid.v1();
    return await taskCollection.document().setData({
      'user_id': uid,
      'task_id': taskId,
      'taskName': taskName,
      'priority': priority,
      'progress': progress,
    });
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
          taskName: doc.data['taskName'] ?? '',
          priority: doc.data['priority'] ?? 0,
          progress: doc.data['progress'] ?? 0);
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
