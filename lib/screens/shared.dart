import 'package:dotodo/services/categories.dart';
import 'package:flutter/material.dart';

class SharedWidgets {
  final task;

  SharedWidgets({this.task});

  CircleAvatar buildAvatar(
      {String categoryName, Color backgroundColor, Color foregroundColor}) {
    String category = categoryName ?? task.category ?? "Task";
    return CircleAvatar(
      backgroundColor: backgroundColor ?? priorityColor(),
      child: Icon(
        Categories().getAvatarImage(category),
        color: foregroundColor ?? Colors.black,
      ),
    );
  }

  Color priorityColor({String priority}) {
    String priorityValue;
    priorityValue = priority ?? task.priority ?? 'low';

    if (priorityValue.compareTo('critical') == 0)
      return Colors.red;
    else if (priorityValue.compareTo('high') == 0)
      return Colors.yellow[700];
    else
      return Colors.green;
  }
}
