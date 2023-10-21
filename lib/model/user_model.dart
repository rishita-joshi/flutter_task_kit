// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String email;
  final String name;
  final String phoneNumber;
  final String imageUrl;

  UserModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
        "imageUrl": imageUrl
      };

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      "imageUrl": imageUrl
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: (map['email'] ?? ''),
        name: (map['name'] ?? ''),
        phoneNumber: map['phoneNumber'],
        imageUrl: map["imageUrl"]);
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
        email: data["email"],
        name: data["name"],
        imageUrl: data["imageUrl"],
        phoneNumber: data["phoneNumber"]);
  }
}
