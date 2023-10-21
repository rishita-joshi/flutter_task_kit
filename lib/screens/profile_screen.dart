import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/components/submit_components.dart';
import 'package:flutter_iterview_task/components/text_form_field.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.ds});
  final DocumentSnapshot ds;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var image;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                getImages();
              },
              child: CircleAvatar(
                child: image != null ? Image.file(image) : Image.network(""),
              ),
            ),
            EventTextBoxWidget(
                hintText: "Enter Email", controller: emailController),
            EventTextBoxWidget(
                hintText: "Enter name", controller: nameController),
            EventTextBoxWidget(
                hintText: "Enter Phone Number", controller: nameController),
            buttonWidget("Update User Data", () {
              updateUserData();
            }, context)
          ],
        ),
      ),
    );
  }

  void getImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      imageUrl = await userService.uploadImage(image);
    }
  }

  void updateUserData() async {
    if (_formKey.currentState!.validate()) {
      await userService.updateTodo(
          widget.ds,
          UserModel(
              email: emailController.text,
              name: nameController.text,
              phoneNumber: phoneController.text,
              imageUrl: imageUrl));
    }
  }
}
