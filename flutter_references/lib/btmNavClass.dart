import 'package:flutter/material.dart';
import 'package:flutter_references/homeClass.dart';
import 'package:flutter_references/tabClasses/tabClass.dart';

class BtmNavClass extends StatefulWidget {
  const BtmNavClass({super.key});

  @override
  State<BtmNavClass> createState() => _BtmNavClassState();
}

class _BtmNavClassState extends State<BtmNavClass> {
  Widget selectedBody = HomeClass();
  String title = "Home";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search", backgroundColor: Colors.yellow),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: Colors.blue,),
        ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          iconSize: 40,
          elevation: 5,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: selectedBody,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 0){
        selectedBody = HomeClass();
      }else if(index == 1){
        selectedBody = const TabClass();
      }else if(index == 2){
      }

    });
  }
}
