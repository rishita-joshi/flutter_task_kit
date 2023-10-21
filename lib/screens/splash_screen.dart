import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/screens/home_list_screen.dart';
import 'package:flutter_iterview_task/screens/login_screen.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //   bool isLogin = await prefs.getBool("isLogin");

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeListScreen(),
      ));
    });
//       if (isLogin) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => HomeListScreen(),
//         ));
//       } else {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         ));
//       }
//     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlutterLogo(),
    ));
  }
}
