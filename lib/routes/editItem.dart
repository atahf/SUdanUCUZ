import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/services/location_picker.dart';
import 'package:project/design/TextStyles.dart';


class EditItem extends StatefulWidget {
   const EditItem({Key? key,required this.name,required this.price,required this.category,required this.image,required this.itemId}) : super(key: key);

  final String category;
  final String name;
  final String price;
  final String image;
  final String itemId;




  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {

  TextEditingController? itemController;

  TextEditingController? itemController2;

  List<String> categories = ["Electronics","Fashion","Book","Art","Craft","Outdoor"];
  String? category;

  LatLng? x;



  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var  profileImage ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Edit yapmanın daha kolay olması için var olan bilgileri gerekli yerlere atıyorum.
    itemController = TextEditingController(text: widget.name);
    category = widget.category;
    itemController2 = TextEditingController(text: widget.price);
  }


  Future updateItem()async{

    // Eğer item için yeni bir fotoğraf yüklendiyse bu fotoğrafı submit changes'e tıklandığında database'e yükleyip itemi güncelliyorum.
    if (profileImage != null){
      var ref = await FirebaseStorage.instance.ref().child("itemPp").child(widget.itemId);
      var uploadTask = await ref.putFile(File(profileImage!.path));
      var url = await uploadTask;
      var res = await url.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("Items").doc(widget.itemId).update({
        "name": itemController!.text,
        "price":itemController2!.text,
        "category": category,
        "image": res,
      });
    }
    else {
      // Eğer yeni bir fotoğraf yüklenmediyse mevcut bilgilerle güncelliyorum, aynı foto kalıyor.
      await FirebaseFirestore.instance.collection("Items").doc(widget.itemId).update({
        "name": itemController!.text,
        "price":itemController2!.text,
        "category": category,
        "image": widget.image,
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Your Item"),
          centerTitle: true,
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
                          child: ClipOval(
                            child: ImagePut(),
                          ),
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

                  updateItem();
                  Navigator.pop(context);
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
                          "Confirm Changes",
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

  Widget ImagePut(){
    // Eğer yeni bir foto yüklendiyse o fotonun ekranda hemen gözükmesini sağlıyorum.
    if (profileImage != null){
      return CircleAvatar(
        backgroundImage: FileImage(File(profileImage!.path)),
        radius: 100,
      );
    }
    else {
      // Eğer foto eklenmediyse eski foto gözüksün.
      return CircleAvatar(
        backgroundImage: NetworkImage(widget.image),
        radius: 100,
      );
    }
  }
}
