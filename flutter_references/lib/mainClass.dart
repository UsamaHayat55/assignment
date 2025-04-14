import 'package:flutter/material.dart';
import 'package:flutter_references/btmNavClass.dart';
import 'package:flutter_references/homeClass.dart';
import 'package:flutter_references/tabClasses/tabClass.dart';

class MainClass extends StatefulWidget {
  const MainClass({super.key});

  @override
  State<MainClass> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  Widget selectedBody = HomeClass();
  String title = "Home";
  int selectedDrawerItem = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(title)),
        drawer: Drawer(child: ListView(
          padding: EdgeInsets.zero,
          children: [
          const DrawerHeader(decoration: BoxDecoration(color: Colors.blue),
            child: Text("Drawer Header"),),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            selected: (selectedDrawerItem == 0),
            selectedColor: Colors.red,
            selectedTileColor: Colors.red.shade50,
            splashColor: Colors.red.shade100,

            onTap: (){
              setState(() {
                title = "Home";
                selectedBody = HomeClass();
                selectedDrawerItem = 0;
                _scaffoldKey.currentState!.closeDrawer();
              });},),

          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text("Tab"),
            selected: (selectedDrawerItem == 1),
            selectedColor: Colors.green,
            selectedTileColor: Colors.green.shade50,
            splashColor: Colors.green.shade100,

            onTap: (){
              setState(() {
                title = "Tab";
                selectedBody = const TabClass();
                selectedDrawerItem = 1;
                _scaffoldKey.currentState!.closeDrawer();
              });},),

          ListTile(
            leading: const Icon(Icons.local_fire_department),
            title: const Text("Firebase"),
            selected: (selectedDrawerItem == 2),
            selectedColor: Colors.blue,
            selectedTileColor: Colors.blue.shade50,
            splashColor: Colors.blue.shade100,

            onTap: (){
              setState(() {
                title = "BtmNav";
                selectedBody = const BtmNavClass();
                selectedDrawerItem = 2;
                _scaffoldKey.currentState!.closeDrawer();
              });},),

        ],),),

        body: selectedBody,

      ),);}

}