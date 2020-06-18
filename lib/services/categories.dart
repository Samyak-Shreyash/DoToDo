import 'package:dotodo/models/taskCategory.dart';
import 'package:flutter/material.dart';

class Categories {
  List<TaskCategory> categoriesData = [
    TaskCategory(name: "Shopping", avatarImage: Icons.shopping_cart),
    TaskCategory(name: "Alarm", avatarImage: Icons.add_alarm),
    TaskCategory(name: "Call", avatarImage: Icons.add_call),
    TaskCategory(name: "Task", avatarImage: Icons.album),
    TaskCategory(name: "Exercise", avatarImage: Icons.accessibility_new),
  ];

  // ignore: missing_return
  List<String> getCategoryList() {
//    print("Category List");
    List<String> categoriesName =
        categoriesData.map((category) => category.name).toList();
    return categoriesName;
  }

  IconData getAvatarImage(String name) {
    for (var category in categoriesData) {
      if (category.name.toLowerCase() == name.toLowerCase()) {
        return category.avatarImage;
      }
    }
    return Icons.assignment_late;
  }
}
