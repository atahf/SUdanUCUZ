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
  Future signInWithGoogle() async {

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      var credit = await _auth.signInWithCredential(credential);
      User user = credit.user!;
      await DatabaseService(uid: user.uid).updateUserData("Add Something", user.displayName??"John", user.email!,"");
      return _userFromFirebase(user);
    }
    catch (e) {
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

