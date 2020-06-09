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

  Future updateUserData(
      String taskName, String priority, String category) async {
    taskId = taskId ?? uuid.v1();
    print(taskId);
    return await taskCollection.document().setData({
      'user_id': uid,
      'task_id': taskId,
      'taskName': taskName,
      'priority': priority,
      'category': category,
    });
  }

  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
          taskName: doc.data['taskName'] ?? '',
          priority: doc.data['priority'] ?? 'low',
          category: doc.data['category'] ?? 'shopping');
    }).toList();
  }

  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }
}
