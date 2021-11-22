import 'package:flutter/material.dart';
import 'loading.dart';
import '../design/TextStyles.dart';
import '../design/ColorPalet.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  void goPage(String pageRoute) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Loading(routeName: pageRoute),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Welcome",
          style: appBarText,
        ),
        centerTitle: true,
        backgroundColor: ColorPalet.main,
      ),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1.5, 2, 1.5, 1.75),
                child: RichText(
                  text: const TextSpan(
                    text: "",
                  ),
                ),
              ),
            ),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.network("https://i.imgur.com/65OdlnF.jpg"),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        goPage("/signup");
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Signup',
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8.0,),

                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        goPage("/login");
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Text("Login"),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
