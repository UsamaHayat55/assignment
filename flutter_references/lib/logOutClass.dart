import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_references/main.dart';
import 'package:flutter_references/mainClass.dart';

class LogOutClass extends StatefulWidget {
  const LogOutClass({super.key});

  @override
  State<LogOutClass> createState() => _LogOutClassState();
}

class _LogOutClassState extends State<LogOutClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Container(alignment: Alignment.center,child: ElevatedButton(onPressed: () async{

          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return MainClass();
          }));

        }, child: Text("LogOut")),),
      ),
    );
  }
}
