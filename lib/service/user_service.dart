import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/TodoModel.dart';
import '../model/user_model.dart';

class UserService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final fireStore = FirebaseFirestore.instance;

  Future<String> saveToFirebase(var request) async {
    final docTodo = fireStore
        .collection("users")
        .doc(firebaseUser!.uid)
        .collection("todos");
    //request.id = docTodo.id;
    // docTodo.orderBy("createdTime");
    await docTodo.add(request);
    return docTodo.id;
  }

  Stream<QuerySnapshot> getDataFromFirebase() {
//  String links =  fireStore.collection("users").get();
    return fireStore
        .collection("users")
        .doc(firebaseUser!.uid)
        .collection('todos')
        //  .orderBy(s, descending: bool)
        .snapshots();
  }

  Future deleteTodos(DocumentSnapshot snapshot) {
    var docid = fireStore
        .collection("users")
        .doc(firebaseUser!.uid)
        .collection('todos')
        .doc(snapshot.id)
        .delete();
    print(docid);
    return docid;
  }

  Future updateTodo(DocumentSnapshot snapshot, var request) async {
    final updateId = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('todos')
        .doc(snapshot.id)
        .update(request);
    return updateId;
  }

  searchData(String data) {
    var searches = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("todos")
        .where('title', arrayContains: data)
        .snapshots();
    // .where('name', isLessThan: name + 'z')
    // .snapshots();
    return searches;
  }

  Stream<QuerySnapshot> sortData(String s, bool bool) {
    var data1 = fireStore
        .collection("users")
        .doc(firebaseUser!.uid)
        .collection('todos')
        .orderBy(s, descending: bool)
        .snapshots();
    return data1;
  }

  Future<String> uploadImage(File imagePath) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${imagePath.path.split('/').last}');
    UploadTask uploadTask = storageReference.putFile(imagePath);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String downloadURL = await storageReference.getDownloadURL();
    print('File Uploaded: $downloadURL');
    return downloadURL;
  }
}


//working update code.
  // String descriptionText) async {
  //   final updateId = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser.uid)
  //       .collection('todos')
  //       .doc(snapshot.id)
  //       .update({'title': titleText, 'description': descriptionText});
  //   return updateId;