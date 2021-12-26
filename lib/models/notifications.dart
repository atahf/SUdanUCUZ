import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/design/TextStyles.dart';

class Notifications{
  int notNum = 0;

  List <String> titles = [];
  List <String> descs = [];

  void addNotification(String? title, String? desc) {
    notNum++;
    titles.add(title!);
    descs.add(desc!);
  }

  int getNotificationsCount() => notNum;

  Widget getNotifications() {
    return ListView.builder(
      itemCount: notNum,
      itemBuilder: (context, index){
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child:
            Row(
              children: <Widget>[
                Text(
                  titles[index],
                  style: generalTextStyle,
                ),
                const SizedBox(width:10.0),
                const Spacer(),
                Text(
                  descs[index],
                  style: generalTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NotificationView extends StatefulWidget {
  Notifications notifs = Notifications();

  NotificationView({ Key? key, required this.notifs }): super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          "Notifications",
          style: appBarText,
        ),
      ),
      body: SafeArea(
        child: widget.notifs.getNotifications(),
      ),
    );
  }
}
