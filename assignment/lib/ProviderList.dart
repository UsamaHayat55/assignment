import 'package:assignment/ProviderClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Results.dart';

class ProviderList extends StatefulWidget {
  const ProviderList({super.key});

  @override
  State<ProviderList> createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderClass(),
      child: MaterialApp(
        home: ItemListScreen(),
      ),

    );
  }
}

class ItemListScreen extends StatefulWidget{
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProviderClass>(context, listen: false).fetchItems(isInitialLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(preferredSize: const Size.fromHeight(140.0),
        child: Card(
          margin: const EdgeInsets.all(10),
          color: const Color(0xFF5A45FE),
          child: Padding(padding: const EdgeInsets.all(10),
            child: Column(children: [

              AppBar(leading: const Icon(Icons.arrow_back, color: Colors.white,), title: const Text("Dating List", style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.transparent, centerTitle: true,),
              CupertinoSearchTextField(backgroundColor: Colors.white, borderRadius: BorderRadius.circular(25),),

            ],),
          ),),),

      body: Consumer<ProviderClass>(
        builder: (context, providerClass, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent &&
                  !providerClass.isLoading &&
                  providerClass.hasMoreItems) {
                providerClass.fetchItems();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: providerClass.results.length + 1,
              itemBuilder: (context, index) {
                if (index < providerClass.results.length) {
                  final data = providerClass.results[index];
                  return listItem(data);
                }else{
                  return providerClass.isLoading ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                      : const SizedBox.shrink();
                }


              },
            ),
          );
        },
      ),
    );
  }

  Widget listItem(Results data) {

    return Card(color: const Color(0xFFEDEEF5),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [

          const Row(children: [
            Icon(Icons.calendar_today, color: Color(0xFF5A45FE),),

            Expanded(child: Text("\tDate", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),

            Icon(Icons.more_horiz, color: Colors.black,),
          ],),

          const Divider(color: Colors.grey,),

          Row(children: [
            SizedBox(width: 50,height: 50,
              child: ClipOval(child:
              Image.network(data.picture.thumbnail.toString(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
              )),
            ),

            const SizedBox(width: 5,),

            Expanded(
              child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${data.name.first} - ${data.dob.age}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const Text("3 km from you", style: TextStyle(fontSize: 12, color: Colors.grey),),
                ],),
            ),

            const Icon(Icons.chat, color: Color(0xFF5A45FE)),

            const SizedBox(width: 10),

            const Icon(Icons.call, color: Color(0xFF5A45FE)),

          ],),

          Row(children: [
            Expanded(child: Container(margin: const EdgeInsets.all(10),
              child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Row(children: [
                    Icon(Icons.calendar_today, color: Colors.black,size: 16,),
                    Text("\tDate", style: TextStyle(color: Colors.black),),
                  ],),

                  Text(getDate(data.registered.date)),

                ],),
            )),

            Expanded(child: Container(margin: const EdgeInsets.all(10),
              child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Row(children: [
                    Icon(Icons.location_on_outlined, color: Colors.black,size: 16,),
                    Text("\tLocation", style: TextStyle(color: Colors.black),),
                  ],),

                  Text("${data.location.state}, ${data.location.city}"),

                ],),
            )),

          ],)

        ],),
      ),);

  }

  String getDate(String data) {
    List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    String date = data.substring(0, 10).replaceAll('-', ' ');
    DateTime specificDate = DateTime.parse(data);
    String dayName = daysOfWeek[specificDate.weekday - 1];
    int hours = specificDate.hour>12 ? specificDate.hour-12 : specificDate.hour;
    String dt = specificDate.hour>12 ? " PM": " AM";

    int minutes = specificDate.minute;

    String time = "$hours:$minutes$dt";

    return ("$dayName, $date\n$time");

  }

}
