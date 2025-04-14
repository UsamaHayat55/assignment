import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_references/mainClass.dart';
import 'package:flutter_references/tabClasses/sliversClass.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(name: "flutter-references",
      options: const FirebaseOptions(
      apiKey: "AIzaSyDle5-TQ8ZAVkUv0Kpgp8SNNGEMJaYnFHs",
      authDomain: "testing-e15d5.firebaseapp.com",
      databaseURL: "https://testing-e15d5-default-rtdb.firebaseio.com",
      projectId: "testing-e15d5",
      storageBucket: "testing-e15d5.appspot.com",
      messagingSenderId: "411537978435",
      appId: "1:411537978435:web:2713c1edce8e1dfcd590f6",
      measurementId: "G-8KZ2FJEBLK"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainClass(),
    );
  }
}