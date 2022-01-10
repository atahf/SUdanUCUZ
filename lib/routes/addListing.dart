import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/services/itemsService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddListing extends StatefulWidget {
  const AddListing({Key? key}) : super(key: key);

  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {

  TextEditingController itemController = TextEditingController();
  TextEditingController itemController2 = TextEditingController();
  TextEditingController itemController3 = TextEditingController();
  List<String> categories = ["Electronics","Fashion","Book","Art","Craft","Outdoor"];
  String? category;

  itemsService _itemsService = itemsService();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var  profileImage;

  Widget imagePlace(){
    double height = MediaQuery.of(context).size.height;
    if(profileImage != null){
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImage!.path)),
        radius: height * 0.15,
      );

    }
    else {
      if (_pickImage != null){
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
          radius: height * 0.15,
        );
      }
      else {
        return CircleAvatar(
          backgroundImage: AssetImage("assets/eminem.jpg"),
          radius: height * 0.15,
        );
      }
    }
  }







  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("List Your Item"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                          controller: itemController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Description",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          )),

                      SizedBox(
                        height: 6,
                      ),

                      TextField(
                          controller: itemController2,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Price",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton<String>(
                        hint: Text("Please select a category"),
                        value: category,
                          isExpanded: true,
                          items: categories.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() => category = value),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: imagePlace(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.camera,
                                  context: context),
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.blue,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () => _onImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context),
                              child: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 25),
              child: InkWell(
                onTap: () {
                  _itemsService
                      .addItem(itemController.text, profileImage ?? "",itemController2.text,category!,FirebaseAuth.instance.currentUser!.uid)
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "Your Item is Succesfully Listed",
                        timeInSecForIosWeb: 2,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 14);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      //color: colorPrimaryShade,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child: Text(
                          "List it",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("dosyaya geldim: $profileImage");
        if (profileImage != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }


  DropdownMenuItem<String> buildMenuItem(String item){
    return DropdownMenuItem(
      value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
    );
  }
}
