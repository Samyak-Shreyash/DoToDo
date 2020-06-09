import 'package:flutter/material.dart';

class Categories {
  final categoriesData = [
    {
      "Shopping": Icons.shopping_basket,
      "Alarm": Icons.add_alarm,
      "Call": Icons.add_call,
      "Task": Icons.album
    }
  ];

  // ignore: missing_return
  List<String> getCategoryList() {
    print("Category List");
  }
}
