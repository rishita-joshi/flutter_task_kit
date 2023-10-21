import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/screens/login_screen.dart';
import 'package:flutter_iterview_task/screens/splash_screen.dart';
import 'package:flutter_iterview_task/service/auth_service.dart';
import 'package:flutter_iterview_task/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/sql_database.dart';
import 'firebase_options.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
AuthServices authServices = AuthServices();
UserService userService = UserService();
var database;
var prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DataBase handler;

  @override
  void initState() {
    handler = DataBase();
    handler.initializedDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreeen());
  }
}
