import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/model/user_model.dart';
import '../components/submit_components.dart';
import '../components/text_form_field.dart';
import 'home_list_screen.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              EventTextBoxWidget(
                controller: controller1,
                hintText: "Enter Employee Name",
              ),
              SizedBox(
                height: 15,
              ),
              EventTextBoxWidget(
                controller: controller2,
                hintText: "Enter Employee Email",
              ),
              SizedBox(
                height: 15,
              ),
              EventTextBoxWidget(
                controller: controller3,
                hintText: "Enter Employee details",
              ),
              SizedBox(
                height: 15,
              ),
              buttonWidget("Add Data", () {
                if (_formKey.currentState!.validate()) {
                  userService
                      .saveToFirebase(UserModel(
                              imageUrl:
                                  "https://images.unsplash.com/photo-1695914990931-c5ec0d2f39a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                              email: controller1.text,
                              name: controller2.text,
                              phoneNumber: controller3.text)
                          .toJson())
                      .then((value) => {
                            if (value.isNotEmpty)
                              {
                                print("Data Inserted"),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeListScreen()),
                                )
                              }
                          });
                }
              }, context),
            ],
          ),
        ),
      ),
    );
  }
}
