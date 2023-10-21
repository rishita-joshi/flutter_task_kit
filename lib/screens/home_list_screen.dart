import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/components/text_form_field.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/screens/profile_screen.dart';
import '../model/user_model.dart';
import 'add_data_screen.dart';

class HomeListScreen extends StatefulWidget {
  const HomeListScreen({super.key});
  @override
  State<HomeListScreen> createState() => _HomeListScreenState();
}

class _HomeListScreenState extends State<HomeListScreen> {
  var searchControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//         actions: [IconButton(onPressed: () {
//  Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const ()),
//             );

//         }, icon: Icon(Icons.edit))],
//         title: Text(""),
          ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddData()),
            );
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 15,
              ),
              EventTextBoxWidget(
                controller: searchControlller,
                hintText: 'Search Text here...',
              ),
              SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: userService.getDataFromFirebase(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      final List<UserModel> tasks =
                          snapshot.data!.docs.map((doc) {
                        return UserModel.fromMap(
                            doc.data() as Map<String, dynamic>);
                      }).toList();
                      print("--->");
                      print(tasks);
                      return Expanded(
                        child: ListView.builder(
                            itemCount: tasks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              // final DocumentSnapshot ds =
                              //     snapshot.data!.docs[index];
                              // UserModel userModel = UserModel.fromJson(
                              //     ds.data() as Map<String, dynamic>);
                              // print(ds);
                              return ListTile(
                                //  trailing: IconButton(
                                //  onPressed: () {
                                //    Navigator.push(
                                //      context,
                                //      MaterialPageRoute<void>(
                                //        builder: (BuildContext context) =>
                                //            ProfileScreen(ds: ds),
                                //      ),
                                //    );
                                //  },
                                //    icon: Icon(Icons.edit)),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      "https://images.unsplash.com/photo-1695914990931-c5ec0d2f39a1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60"),
                                ),
                                title: Text(tasks[index].email),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    return CircularProgressIndicator();
                  })
            ]),
      ),
    );
  }
}

// List<UserModel> taskListFromSnapshot(QuerySnapshot snapshot) {
//   return snapshot.docs.map((doc) {
//     return UserModel(
//       email: doc.,
//       imageUrl: '',
//       name: '',
//       phoneNumber: '',
//     );
//   }).toList();
// }
