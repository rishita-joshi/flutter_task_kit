import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/model/user_model.dart';

import '../database/sql_database.dart';
import 'sql_display_page.dart';

class SqlDbScreen extends StatefulWidget {
  const SqlDbScreen({super.key});

  @override
  State<SqlDbScreen> createState() => _SqlDbScreenState();
}

DataBase db = DataBase();
List items = ["ADD", "MIN", "DIV", "MUL"];

String selectedValue = "ADD";
final _formKey = GlobalKey<FormState>();

class _SqlDbScreenState extends State<SqlDbScreen> {
  var firstValueController = TextEditingController();
  var SecondValueController = TextEditingController();
  var displayValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please Enter Value 1';
                    }
                  },
                  decoration: InputDecoration(hintText: "Enter Value 1"),
                  controller: firstValueController,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please Enter Value 2';
                    }
                  },
                  decoration: InputDecoration(hintText: "Enter Value 2"),
                  controller: SecondValueController,
                  keyboardType: TextInputType.number,
                ),
                DropdownButton(
                  value: selectedValue,
                  hint: Text("Select Opration"),
                  items: items.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      oprationPerform();
                    },
                    child: Text("Calculate")),
                Text(displayValue.toString()),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SqlDisplayPage()),
                      );
                    },
                    child: Text("Histroy")),
              ]),
        ),
      ),
    );
  }

  void oprationPerform() {
    if (_formKey.currentState!.validate()) {
      var cal = UserModel(email: '', name: '', phoneNumber: '', imageUrl: '');
      db.insert(cal.toJson());
    } else {
      print("Form not Validate");
    }
    setState(() {
      firstValueController.text = "";
      SecondValueController.text = "";
    });
  }
}
