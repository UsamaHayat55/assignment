import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_references/utils/dataModel.dart';
import 'package:flutter_references/utils/databaseHelper.dart';
import 'package:flutter_references/utils/utilsClass.dart';
import 'package:http/http.dart' as http;

class ListViewClass extends StatefulWidget {
  const ListViewClass({super.key});

  @override
  State<ListViewClass> createState() => _ListViewClassState();
}

class _ListViewClassState extends State<ListViewClass> {

  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<DataModel> list = [];

  List<String> name = ["Ahmed", "Badar", "Careem", "Danial", "Ehsan"];
  List<int> age = [12, 34, 45, 56, 67];
  int selectedSourse = 0;

  String dialogueText = "", t = "";

  @override
  Widget build(BuildContext context) {
    
    getData();
    
    return  MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [

            Container(margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Radio(value: 0, groupValue: selectedSourse, onChanged: (a){
                    setState(() {
                      selectedSourse = a!;
                    });
                  }),
                  Text("SQLite"),

                  Radio(value: 1, groupValue: selectedSourse, onChanged: (a){
                    setState(() {
                      selectedSourse = a!;
                    });
                  }),
                  Text("Firebase"),

                  Radio(value: 2, groupValue: selectedSourse, onChanged: (a){
                    setState(() {
                      selectedSourse = a!;
                    });
                  }),
                  Text("Api"),
              ],),
            ),
            
            Expanded(
              child: ListView.builder(itemCount: list.length,
                  itemBuilder: (context, position){
                return Card(
                  margin: const EdgeInsets.only(top: 10, left: 10, bottom: 0, right: 10),
                  shape: const RoundedRectangleBorder(
              //            borderRadius: BorderRadius.circular(15),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
              //            topRight: Radius.circular(15),
              //            bottomLeft: Radius.circular(15),
              //            bottomRight: Radius.circular(15),
                  ),
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: getVisibility(position),
                            child: Container(width: 100, height: 100,
                            child: ClipOval(child: Image.network(t+list[position].imgUrl.toString(), fit: BoxFit.fill,)),),
                          ),

                          Text("Name: ${list[position].name}"),
                          const SizedBox(height: 5),
                          Text("Age: ${list[position].age}"),
              
              /*
                          Text("Name: ${name[position]}"),
                          SizedBox(height: 5),
                          Text("Age: ${age[position]}"),
              */
                        ],),
                    ),
                    onTap: (){
              
                    showDialog(context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.black38,
                        builder: (BuildContext context){
                      return Container(
                        margin: const EdgeInsets.all(15),
                        child: Row(children: [
                          Expanded(child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(mainAxisSize: MainAxisSize.min,
                              children: [
              
                                const Text("This is a Dialog Box", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              
                                const SizedBox(height: 10),
              
                                TextField(onChanged: (newDialogueText){dialogueText = newDialogueText;},
                                    decoration: const InputDecoration(
                                  labelText: "Text",
                                  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.blue),
                                  ),
                                  border: OutlineInputBorder(),
                                )),
              
                                const SizedBox(height: 10),
              
                                Row(children: [
                                  Expanded(child: ElevatedButton(onPressed: (){UtilsClass().newToast(dialogueText);}, child: const Text("Toast"))),
              
                                  const SizedBox(width: 10),
              
                                  Expanded(child: ElevatedButton(onPressed: (){
                                    _dbHelper.deleteItem(list[position].id!.toInt());
                                    getData();
                                    UtilsClass().newToast("Item Deleted");
                                    Navigator.pop(context);
                                  }, child: const Text("Delete"))),
              
                                  const SizedBox(width: 10),
              
                                  Expanded(child: ElevatedButton(onPressed: (){
                                    Navigator.of(context, rootNavigator: true).pop();
                                  }, child: const Text("Close"))),
                                ],)
              
                              ],),
                            ),))
                        ],),
                      );
              
                    });
              
                    },
                  ),
                );
              
              }),
            ),
          ],
        ),
      ),
    );
  }

  void getData(){

    if(selectedSourse == 0){
      t = "";
      getFromSqfLite();
    }else if(selectedSourse == 1){
      t = "";
      getFromFirebase();
    }else if(selectedSourse == 2){
      String ip = UtilsClass().ip;
      t = "http://$ip/flutter/api/uploads/";
      getFromApi();
    }
  }

  Future<void> getFromSqfLite() async{
    final sqlData = await _dbHelper.retrieveItems();
    setState(() {
      list = sqlData;
    });
    
  }

  Future<void> getFromFirebase() async{

    DatabaseReference databaseReference = FirebaseDatabase.instance.ref("FlutterDatabase").child("User Data");

    List<DataModel> nl = [];
    DatabaseEvent event = await databaseReference.once();
    Map<dynamic,dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
    nl = values.entries.map((entry){
      return DataModel.fromMap(entry.value);
    }).toList();

    setState(() {
      list = nl;
    });


/*
    databaseReference.onValue.listen((event){
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic,dynamic>? values = snapshot.value as Map?;
      values!.forEach((key, value) {
        nl.add(DataModel(name: value['name'], age: value['age'], imgUrl: value['imgUrl']));
      });

      setState(() {
        list = nl;
      });

    });
*/

  }

  Future<void> getFromApi() async{

    String ip = UtilsClass().ip;
    String url = "http://$ip/flutter/api/retrieve.php";
    List<DataModel> apiList = [];

    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      var responseData = json.decode(response.body);

/*
      for (var singleItem in responseData) {
        DataModel user = DataModel(
            id: int.parse(singleItem["id"]),
            name: singleItem["name"],
            age: singleItem["age"],
            imgUrl: "http://$ip/flutter/api/uploads/"+singleItem["imgUrl"]);

        apiList.add(user);
      }
*/

      apiList = (responseData as List).map((data) => DataModel.fromMap(data)).toList();

    }else{
      print("----------------"+response.statusCode.toString());
    }

    setState(() {
      list = apiList;
//      list.addAll(apiList);
    });

  }

  bool getVisibility(int position) {
    if(selectedSourse == 0){
      return false;
    }else{
      return true;
    }
  }

}
