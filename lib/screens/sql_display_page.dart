import 'package:flutter/material.dart';
import '../database/sql_database.dart';
import '../main.dart';
import '../model/user_model.dart';

class SqlDisplayPage extends StatefulWidget {
  const SqlDisplayPage({super.key});

  @override
  State<SqlDisplayPage> createState() => _SqlDisplayPageState();
}

class _SqlDisplayPageState extends State<SqlDisplayPage> {
  List<UserModel> cal = [];
  DataBase dataBase = DataBase();
  @override
  void initState() {
    getDataCal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: cal.length > 0
              ? ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: cal.length,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   title: Text(
                    //       "${cal[index].value1}  ${cal[index].opration.toString()}  ${cal[index].value2} = ${cal[index].ans} "),
                    // );
                  })
              : Center(child: CircularProgressIndicator()),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }

  void getDataCal() async {
    List<UserModel> data = [];
    data = await dataBase.getData();
    setState(() {
      cal.addAll(data);
    });
  }
}
