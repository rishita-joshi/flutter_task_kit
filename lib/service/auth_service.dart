import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/screens/home_list_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class AuthServices {
  Future<User?> createAuthUser(String email, String password) async {
    User? userCredential;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value);
        userCredential = value.user!;
      });
    } on FirebaseException catch (error) {
      if (error.code == "ERROR_EMAIL_ALREADY_IN_USE" ||
          error.code == "account-exists-with-different-credential" ||
          error.code == "email-already-in-use") {
        try {
          await _auth
              .signInWithEmailAndPassword(email: email!, password: password!)
              .then((value) {
            userCredential = value.user!;
          });
        } on FirebaseException catch (error) {}
      } else {}
    }
    return userCredential;
  }

//   Future<void> signUpWithEmailPassword(context,
//       {String? name,
//       String? email,
//       String? password,
//       String? mobileNumber,
//       String? lName,
//       String? userName,
//       bool? isOTP,
//       String? userType,
//       bool isAddUser = false}) async {
//     try {
//       createAuthUser(email, password).then((user) async {
//         if (user != null) {
//           await signInWithEmailPassword(context,
//                   email: email!, password: password!)
//               .then((value) {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => HomeListScreen()),
//                 (Route<dynamic> route) => false);
//           });
//         }
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }

  Future signInWithEmailPassword(context,
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        //   prefs.setBool("isLogin", true);
        if (value.user!.uid != null) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeListScreen(),
            ),
          );
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  sendOtp(BuildContext context,
      {required String phoneNumber, required Function(String) onUpdate}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // toast(language.verificationCompleted);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            // throw language.phoneNumberInvalid;
          } else {
            throw e.message.toString();
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          onUpdate.call(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseException catch (error) {}
  }

  Future<AuthCredential> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      //  prefs.setBool("isLogin", true);

      return credential;
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }
}
