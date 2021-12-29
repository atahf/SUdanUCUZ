import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:project/services/DatabaseService.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }



  Future signupWithMailAndPass( String mail, String pass,String name,String lastName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;

      //await _firestore.collection("UserInfos").doc(user.uid).set({"userName": name,"email":mail,"lastName":lastName});
      //var list_name = new List.filled(3, null, growable: false);

      await DatabaseService(uid: user.uid).updateUserData("Add Something", name, mail, lastName);
      return _userFromFirebase(user);

    } catch (e) {

      return null;
    }

  }

  Future loginWithMailAndPass(BuildContext context, String mail, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {

      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class AuthServiceSignUpGoogle {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthServiceSignUpGoogle.customSnackBar(
              content:
              'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthServiceSignUpGoogle.customSnackBar(
              content:
              'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          AuthServiceSignUpGoogle.customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthServiceSignUpGoogle.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}