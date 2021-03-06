import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project/services/auth.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String _message = '';
  int attemptCount = 0;
  String mail = '';
  String password = '';
  String fname = '';
  String lname = '';

  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService authService = AuthService();


  void setMessage(String msg) {
    setState(() {
      _message = msg;
    });
  }

  Future<void> signupUser() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: mail, password: password);
      print(userCredential.toString());
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if(e.code == 'email-already-in-use') {
        setMessage('This email is already in use');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('This email is already in use'))
        );
      }
      else if(e.code == 'weak-password') {
        setMessage('Weak password, add uppercase, lowercase, digit, special character, emoji, etc.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Weak password, add uppercase, lowercase, digit, special character, emoji, etc.'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalet.main,
      appBar: AppBar(
        title: Text(
          "Signup",
          style: appBarText,
        ),
        backgroundColor: ColorPalet.titleC,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "firstname",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorPalet.buttonBack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if(value == null) {
                      return "firstname field cannot be empty";
                    }
                    else {
                      String trimmedValue = value.trim();
                      if(trimmedValue.isEmpty) {
                        return "firstname field cannot be empty";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if(value != null) {
                      fname = value;
                    }
                  },
                ),

                const SizedBox(height: 7.5),

                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "lastname",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorPalet.buttonBack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if(value == null) {
                      return "lastname field cannot be empty";
                    }
                    else {
                      String trimmedValue = value.trim();
                      if(trimmedValue.isEmpty) {
                        return "lastname field cannot be empty";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if(value != null) {
                      lname = value;
                    }
                  },
                ),

                const SizedBox(height: 7.5),

                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "e-mail",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorPalet.buttonBack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if(value == null) {
                      return "e-mail field cannot be empty";
                    }
                    else {
                      String trimmedValue = value.trim();
                      if(trimmedValue.isEmpty) {
                        return "e-mail field cannot be empty";
                      }
                      if(!EmailValidator.validate(trimmedValue)) {
                        return "please enter a valid e-mail";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if(value != null) {
                      mail = value;
                    }
                  },
                ),

                const SizedBox(height: 7.5),

                TextFormField(
                  obscuringCharacter: '*',
                  obscureText: true,
                  enableSuggestions: false,
                  enableIMEPersonalizedLearning: false,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorPalet.buttonBack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if(value == null) {
                      return "password field cannot be empty";
                    }
                    else {
                      String trimmedValue = value.trim();
                      if(trimmedValue.isEmpty) {
                        return "password field cannot be empty";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if(value != null) {
                      password = value;
                    }
                  },
                ),

                /*const SizedBox(height: 7.5),

                TextFormField(
                  obscuringCharacter: '*',
                  obscureText: true,
                  enableSuggestions: false,
                  enableIMEPersonalizedLearning: false,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "re-password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorPalet.buttonBack,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  validator: (value) {
                    if(value == null) {
                      return "re-password field cannot be empty";
                    }
                    else {
                      String trimmedValue = value.trim();
                      if(trimmedValue.isEmpty) {
                        return "re-password field cannot be empty";
                      }
                      if(trimmedValue != password) {
                        return "passwords should match";
                      }
                    }
                    return null;
                  },
                ),*/

                const SizedBox(height: 7.5),

                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      authService.signupWithMailAndPass(mail, password, fname, lname);
                      Navigator.pop(context);

                    }
                  },
                  child: const Text("Create"),
                  style: mainBstyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
