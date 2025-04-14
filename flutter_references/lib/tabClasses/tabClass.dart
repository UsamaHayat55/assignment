import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_references/tabClasses/firebaseDatabaseClass.dart';
import 'package:flutter_references/tabClasses/sliversClass.dart';

import 'insertClass.dart';
import 'listViewClass.dart';

class TabClass extends StatefulWidget {
  const TabClass({super.key});

  @override
  State<TabClass> createState() => _TabClassState();
}

class _TabClassState extends State<TabClass> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(tabs: [
            Tab(icon: Icon(Icons.insert_chart_outlined), text: "Insert"),
            Tab(icon: Icon(Icons.list_alt), text: "Recycler"),
            Tab(icon: Icon(Icons.list_alt), text: "Firebase"),
            Tab(icon: Icon(Icons.list_alt), text: "Slivers"),
        ],
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.blue,),
          body: TabBarView(children: [
            InsertClass(),
            ListViewClass(),
            FirebaseDatabaseClass(),
            SliversClass()
          ]),

        ),
      ),
    );
  }
}