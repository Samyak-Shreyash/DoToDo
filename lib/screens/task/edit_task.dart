import 'package:dotodo/models/task.dart';
import 'package:dotodo/models/user.dart';
import 'package:dotodo/screens/shared.dart';
import 'package:dotodo/services/ValidationRules.dart';
import 'package:dotodo/services/categories.dart';
import 'package:dotodo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  double _priorityValue;

  @override
  Widget build(BuildContext context) {
  _priorityValue=getPriorityValue(widget.task.priority);
    final user = Provider.of<User>(context);
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

              setState(() => widget.task.title = val);
            },
            decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
              value: widget.task.category ?? "",
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: <Widget>[
                      SharedWidgets().buildAvatar(categoryName: category,
                          backgroundColor: Colors.grey[400],
                          foregroundColor: Colors.black),
                      SizedBox(width: 10.0),
                      Text(category!=""?category:"Uncategorized")
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() => widget.task.category = val);
              }),
          SizedBox(height: 20.0),
          Slider(
            value: _priorityValue ?? 1.0,
            activeColor: SharedWidgets().priorityColor(
                priority: widget.task.priority ?? "low"),
            inactiveColor: Colors.grey,
            min: 1.0,
            max: 3.0,
            divisions: 2,
            onChanged: (double value) {
              setState(() {
                _priorityValue = value;
                widget.task.priority = setPriority(_priorityValue);
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
              if (_formKey.currentState.validate()) {
                widget.task.priority = widget.task.priority ?? "low";
                widget.task.category = widget.task.category ?? "";
                widget.task.parentID = widget.task.parentID ?? user.id;
//                debugPrint(widget.task.toJson().toString());
                await DatabaseService(id:user.id).updateUserData(widget.task);

              }


            },
          ),
        ],
      ),
    );
  }

  Color priorityColor() {
    // ignore: unnecessary_statements
    widget.task.priority = widget.task.priority ?? 'low';
    Color returnColor = Colors.green;

    if (widget.task.priority.compareTo('low') == 0) returnColor = Colors.green;
    if (widget.task.priority.compareTo('high') == 0) returnColor = Colors.yellow[700];
    if (widget.task.priority.compareTo('critical') == 0) returnColor = Colors.red;
    return returnColor;
  }

  double getPriorityValue(String priority) {
    priority=priority??"";
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
