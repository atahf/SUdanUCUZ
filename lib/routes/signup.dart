import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String mail;
  late String password;

  @override
  void initState() {
    super.initState();
    firstName = "";
    lastName = "";
    mail = "";
    password = "";
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
                      firstName = value;
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
                      lastName = value;
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

                const SizedBox(height: 7.5),

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
                ),

                const SizedBox(height: 7.5),

                ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                      print('fname:$firstName\nlname:$lastName\nmail:$mail\npass:$password');
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
