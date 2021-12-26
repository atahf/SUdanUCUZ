import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'feedView.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  int attemptCount = 0;
  String mail = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  bool _isSigningIn = false;

  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);


    if(user == null) {
      return Scaffold(
        backgroundColor: ColorPalet.main,
        appBar: AppBar(
          title: Text(
            "Login",
            style: appBarText,
          ),
          backgroundColor: ColorPalet.titleC,
          centerTitle: true,
        ),
        body: SafeArea(
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
              child: Column(
                children: [
                  _isSigningIn
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ) : OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningIn = true;
                      });

                      User? user =
                      await AuthServiceSignUpGoogle.signInWithGoogle(context: context);

                      setState(() {
                        _isSigningIn = false;
                      });

                      if (user != null) {
                        print("success");
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/feedview");
                      }

                      setState(() {
                        _isSigningIn = false;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const Divider(thickness: 2, color: Colors.white),

                  Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          if (value == null) {
                            return "e-mail field cannot be empty";
                          }
                          else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return "e-mail field cannot be empty";
                            }
                            if (!EmailValidator.validate(trimmedValue)) {
                              return "please enter a valid e-mail";
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
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
                          if (value == null) {
                            return "password field cannot be empty";
                          }
                          else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return "please enter a valid password";
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            password = value;
                          }
                        },
                      ),

                      const SizedBox(height: 7.5),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            auth.loginWithMailAndPass(context, mail, password);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Logging in')));
                          }
                        },
                        child: const Text("Login"),
                        style: mainBstyle,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    }

    else {
      return FeedView(analytics: analytics, observer: observer) ;
    }
  }
}
