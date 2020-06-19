import 'package:flutter/material.dart';
import 'package:dotodo/models/category.dart';

class Categories {

  List<Category> categories = [
    Category(name: 'Shopping', avatarImage: Icons.shopping_cart),
    Category(name: 'Alarm', avatarImage: Icons.add_alarm),
    Category(name: 'Call', avatarImage: Icons.add_call),
    Category(name: 'Task', avatarImage: Icons.album),
    Category(name: 'Exercise', avatarImage: Icons.accessibility_new),
  ];

  List<String> getCategoryList() {

    if(categories!=null)
    {
      List<String> _categoriesName= categories.map((category) => category.name).toList();
        return _categoriesName;
      }
    else
      return null;
    }

    IconData getAvatarImage(String categoryName)
    {
      print("Current Category: $categoryName");
      for (var category in categories){
        if (category.name.toLowerCase()==categoryName.toLowerCase())
          return category.avatarImage;
      }
      return Icons.album;
    }
}
