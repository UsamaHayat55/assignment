import 'package:flutter/material.dart';

class SliversClass extends StatefulWidget {
  const SliversClass({super.key});

  @override
  State<SliversClass> createState() => _SliversClassState();
}

class _SliversClassState extends State<SliversClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [

          CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Flutter Slivers'),
                background: Image.network(
                  'https://example.com/header_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Welcome to the world of Flutter Slivers!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 50,
              ),
            ),
          ],)
        ],),
      ),
    );
  }
}
