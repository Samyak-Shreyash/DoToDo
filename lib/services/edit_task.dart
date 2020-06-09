//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotodo/models/task.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'ValidationRules.dart';
import 'categories.dart';

class SettingsPanel {
  final Task task;
  BuildContext context;

  SettingsPanel(this.task, this.context);

  void showSettingsPanel() {
    String title = '${task.taskName}';
    if (title == null || title == '' || title == "null") {
      print("Blank");
      title = "New Task";
    }
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 23.0),
            child: _SettingsForm(),
          );
        });
  }
}

class _SettingsForm extends StatefulWidget {
  @override
  __SettingsFormState createState() => __SettingsFormState();
}

class __SettingsFormState extends State<_SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> categories = ["Shopping", "Call", 'Task', 'Alarm'];

  String _title;
  String _priority;
  double _priorityValue;
  String _category;

  @override
  Widget build(BuildContext context) {
//    Categories().getCategoryList();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Edit Task',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          createTextField('Task Title', TextInputType.text,
              customValidators().textValidation("")),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            value: _category ?? categories[0],
            items: categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _category = val);
            },
          ),
          SizedBox(height: 20.0),
          buildSlider(),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.green,
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_title);
              print(_priority);
              print(_category);
            },
          ),
        ],
      ),
    );
  }

  Slider buildSlider() {
    return Slider(
      value: _priorityValue ?? 1.0,
      activeColor: priorityColor(),
      inactiveColor: Colors.grey,
      min: 1.0,
      max: 3.0,
      divisions: 2,
      onChanged: (double value) {
        setState(() {
          _priorityValue = value;
          _priority = setPriority(_priorityValue);
        });
      },
    );
  }

  TextFormField createTextField(
      String label, TextInputType type, MultiValidator validatorType) {
    return TextFormField(
      validator: validatorType,
      keyboardType: type,
      onChanged: (val) {
        setState(() => _title = val);
      },
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }

  Color priorityColor() {
    // ignore: unnecessary_statements
    _priority = (_priority == null) ? 'low' : _priority;
    Color returnColor = Colors.green;

    if (_priority.compareTo('low') == 0) returnColor = Colors.green;
    if (_priority.compareTo('high') == 0) returnColor = Colors.yellow;
    if (_priority.compareTo('critical') == 0) returnColor = Colors.red;
    return returnColor;
  }
}

String setPriority(double priorityValue) {
  if (priorityValue == 3.0) return "critical";
  if (priorityValue == 2.0) return "high";
  return "low";
}
