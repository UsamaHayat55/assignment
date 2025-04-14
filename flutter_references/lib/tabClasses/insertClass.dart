import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_references/logOutClass.dart';
import 'package:flutter_references/utils/dataModel.dart';
import 'package:flutter_references/utils/databaseHelper.dart';
import 'package:flutter_references/utils/utilsClass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InsertClass extends StatefulWidget {
  const InsertClass({super.key});

  @override
  State<InsertClass> createState() => _InsertClassState();
}

class _InsertClassState extends State<InsertClass> {

  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<DataModel> list = [];

  String name = "", age = "";
  File selectedImg = File("");
  String httpText = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                InkWell(
                  onTap: (){
                    pickImage();
                  },
                  child: Container(width: 250, height: 250,
                      margin: EdgeInsets.only(bottom: 20),
                  child: selectedImage()),
                ),

                TextField(onChanged: (newName){name = newName.trim();},
                  decoration: const InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    border: OutlineInputBorder(),
                ),),
            
                SizedBox(height: 20,),
            
                TextField(onChanged: (newAge){age = newAge.trim();},
                  decoration: const InputDecoration(
                      label: Text("Age"),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red),
                      ),
                      border: OutlineInputBorder(),
                    ),),

                Container(margin: EdgeInsets.all(20),
                  child: const Text("Insert Data Into:"),
                ),

                Row(children: [
                  Expanded(child: ElevatedButton(onPressed: (){
                    setState(() {
                      saveToSqlite();
                    });
                  }, child: Text("Sqlite"))),

                  SizedBox(width: 10,),

                  Expanded(child: ElevatedButton(onPressed: (){
                    saveToFirebase();
                  }, child: Text("Firebase"))),

                  SizedBox(width: 10,),

                  Expanded(child: ElevatedButton(onPressed: (){

//                    saveToApi();
//                  saveImageToApi();
                    saveToApiWithImage();

                  }, child: Text("http"))),

                ],),

                Container(margin: EdgeInsets.all(20),
                  child: const Text("Firebase Login"),
                ),

                Row(children: [
                  Expanded(child: ElevatedButton(onPressed: (){

                    createFirebaseAccount();

                  }, child: Text("SignUp"))),

                  SizedBox(width: 20,),

                  Expanded(child: ElevatedButton(onPressed: () async{

                    UtilsClass().newToast("Please Wait");
                    
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: name, password: age);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return LogOutClass();
                      }));

                    }catch(error){
                      if(error is FirebaseAuthException){
                        switch(error.code.toString()){
                          case 'wrong-password':
                            UtilsClass().newToast("Your Password is incorrect");
                            break;
                          case 'invalid-email':
                            UtilsClass().newToast("Your email is Badly Formatted");
                            break;

                        }

                      }else{
                        UtilsClass().newToast(error.toString());
                      }
                    }

                  }, child: Text("LogIn"))),

                ],),

                SizedBox(height: 2,),

              ],),
          ),
        ),
      ),
    );
  }

  Future<void> saveToSqlite() async{
    DataModel newData = DataModel(name: name, age: age);
    await _dbHelper.insertItem(newData);
    UtilsClass().newToast("Data Saved");
  }

  Future<void> saveToFirebase() async{
    if (selectedImg.existsSync()) {
      final storageReference = FirebaseStorage.instance.ref("FlutterDatabase").child("User Images")
          .child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(selectedImg);
      final snapshot = await storageReference.whenComplete(() => null);
      String imgUrl = await snapshot.ref.getDownloadURL();

      DataModel model = DataModel(name: name, age: age, imgUrl: imgUrl);
      FirebaseDatabase.instance.ref("FlutterDatabase").child("User Data").push().set(model.toMap()).whenComplete(() => UtilsClass().newToast("Data Uploaded"));

    }else{
      UtilsClass().newToast("Please Select Image");
    }
  }


  Widget selectedImage() {
    if (selectedImg.existsSync()) {
      return Image.file(selectedImg);
    } else {
      return Icon(Icons.person_pin, size: 200,);  // Show the default image if not
    }
  }

  Timer? timer;
  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImg = File(pickedImage!.path);
    setState(() {
      selectedImg;
    });

/*
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      UtilsClass().newToast("toastText");
    });
*/

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> createFirebaseAccount() async{

    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: name, password: age);

      UtilsClass().newToast("Account Successfully Created");

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LogOutClass();
      }));

/*
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogOutClass()));
*/

    }catch(error){

      if(error is FirebaseAuthException){
        switch(error.code.toString()){
          case 'email-already-in-use':
            UtilsClass().newToast("This Email is Already in use by another Account");
            break;
          case 'weak-password':
            UtilsClass().newToast("Your Password is too weak");
            break;
          case 'invalid-email':
            UtilsClass().newToast("Your email is Badly Formatted");
            break;

        }

      }else{
        UtilsClass().newToast(error.toString());
      }

    }

  }


  Future<void> saveToApi() async{

/*
    final Map<String, dynamic> map = {
      "name": name,
      "age": age,
      "imgUrl": "imgUrl",
    };
*/

    DataModel model = DataModel(name: name, age: age, imgUrl: "imgUrl");

    String ip = UtilsClass().ip;
    String url = "http://$ip/flutter/api/insert.php";

    http.Response response = await http.post(Uri.parse(url), body: model.toMap());

    if(response.statusCode == 200){
      if(response.body == "1"){
        UtilsClass().newToast("Data Uploaded");
      }else{
        print("--------------------------"+response.body.toString());
      }
    }else{
      print("Error, Server Returns a ${response.statusCode} error");
    }


  }

  Future<void> saveImageToApi() async{

    String ip = UtilsClass().ip;
    String url = "http://$ip/flutter/api/uploadImage.php";

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['name'] = "nme";
    var pic = await http.MultipartFile.fromPath("image", selectedImg.path);
    request.files.add(pic);
    var response = await request.send();

    if(response.statusCode == 200){
      UtilsClass().newToast("Uploaded");
    }else{
      UtilsClass().newToast("Failure");
    }
  }

  Future<void> saveToApiWithImage() async{

    String ip = UtilsClass().ip;
    String url = "http://$ip/flutter/api/uploadDataWithImage.php";

    final request = http.MultipartRequest('POST', Uri.parse(url));
    var pic = await http.MultipartFile.fromPath('img', selectedImg.path);
    request.files.add(pic);
    request.fields['name'] = name;
    request.fields['age'] = age;
    request.fields['saveTo'] = "uploads/";
    request.fields['imgName'] = DateTime.now().millisecondsSinceEpoch.toString();

    var imgResponse = await request.send();

    if(imgResponse.statusCode == 200){
        UtilsClass().newToast("Data Uploaded");
        print("-----------------------------------$imgResponse");
    }else{
      print("Error, Server Returns a ${imgResponse.statusCode} error");
    }


  }

}