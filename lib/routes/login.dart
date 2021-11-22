import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String mail;
  late String password;

  @override
  void initState() {
    super.initState();
    mail = "";
    password = "";
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          child: Form(
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
                        return "please enter a valid password";
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

                const SizedBox(height: 7.5),

                ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      print('mail:$mail \npass:$password');
                    },
                    child: const Text("Login"),
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
