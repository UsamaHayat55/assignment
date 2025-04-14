import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirebaseDatabaseClass extends StatefulWidget {
  const FirebaseDatabaseClass({super.key});

  @override
  State<FirebaseDatabaseClass> createState() => _FirebaseDatabaseClassState();
}


DatabaseReference databaseReference = FirebaseDatabase.instance.ref("FlutterDatabase").child("User Data");

class _FirebaseDatabaseClassState extends State<FirebaseDatabaseClass> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(

          child: FirebaseAnimatedList(query: databaseReference,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){

            Map data = snapshot.value as Map;
            data['key'] = snapshot.key;

            return Card(
              margin: const EdgeInsets.only(top: 10, left: 10, bottom: 0, right: 10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                ),
                side: BorderSide(width: 1, color: Colors.black),
              ),
              elevation: 5,
              shadowColor: Colors.blue,
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${data['name']}"),
                      const SizedBox(height: 5),
                      Text("Age: ${data['age']}"),

                    ],),
                ),
              ),
            );
              }),
        ),
      ),
    );
  }
}
