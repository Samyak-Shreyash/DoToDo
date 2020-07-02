import 'package:dotodo/models/task.dart';
import 'package:dotodo/screens/shared.dart';
import 'package:dotodo/services/ValidationRules.dart';
import 'package:dotodo/services/categories.dart';
import 'package:flutter/material.dart';

class SettingsPanel {
  final Task task;
  BuildContext context;

  SettingsPanel(this.task, this.context);

  void showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 23.0),
            child: _SettingsForm(task: task),
          );
        });
  }
}

class _SettingsForm extends StatefulWidget {
  final Task task;

  _SettingsForm({this.task});

  @override
  __SettingsFormState createState() => __SettingsFormState();
}

class __SettingsFormState extends State<_SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _priority;
  String _category;
  double _priorityValue;

  @override
  Widget build(BuildContext context) {
    List<String> categories = Categories().getCategoryList();
    String formTitle = (widget.task.id != null) ? 'Edit Task' : 'Create Task';
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            formTitle,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: widget.task.title ?? "",
            validator: customValidators().textValidation(""),
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() => _title = val);
            },
            decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
              value: widget.task.category ?? "Task",
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: <Widget>[
                      SharedWidgets().buildAvatar(categoryName: category,
                          backgroundColor: Colors.grey[400],
                          foregroundColor: Colors.black),
                      SizedBox(width: 10.0),
                      Text(category)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => _category = val);
              }),
          SizedBox(height: 20.0),
          Slider(
            value: _priorityValue ?? 1.0,
            activeColor: SharedWidgets().priorityColor(
                priority: _priority ?? "low"),
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
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.green,
            child: Text(
              (widget.task.id != null) ? 'Update' : 'Create',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              _title = _title ?? widget.task.title ?? "";
              _priority = _priority ?? widget.task.priority ?? "low";
              _category = _category ?? widget.task.category ?? "task";
              debugPrint(_title);
              debugPrint(_priority);
              debugPrint(_category);
            },
          ),
        ],
      ),
    );
  }

  Color priorityColor() {
    // ignore: unnecessary_statements
    _priority = _priority ?? 'low';
    Color returnColor = Colors.green;

    if (_priority.compareTo('low') == 0) returnColor = Colors.green;
    if (_priority.compareTo('high') == 0) returnColor = Colors.yellow[700];
    if (_priority.compareTo('critical') == 0) returnColor = Colors.red;
    return returnColor;
  }

  double getPriorityValue(String priority) {
    if (priority.toLowerCase() == "critical") return 3.0;
    if (priority.toLowerCase() == "high") return 2.0;
    return 1.0;
  }
}

String setPriority(double priorityValue) {
  if (priorityValue == 3.0) return "critical";
  if (priorityValue == 2.0) return "high";
  return "low";
}
