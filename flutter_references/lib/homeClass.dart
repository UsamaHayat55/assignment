import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_references/logOutClass.dart';
import 'package:flutter_references/utils/utilsClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeClass extends StatefulWidget {
  @override
  State<HomeClass> createState() => _HomeClassState();
}

class _HomeClassState extends State<HomeClass> {

  bool setIf = false,
      cb1 = false, cbe1 = true,
      cb2 = false, cbe2 = true,
      cb3 = false, cbe3 = true,
      cb4 = false, cbe4 = true,
      cb5 = false, cbe5 = true;

  String txt_change = "Text to be Changed",
      txt_table = "Table",
      preferencesToast = "";
  int txt_table_number = 1,
      limit = 0,
      rg1 = -1,
      rg2 = -1;

  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {

    checkLogin();

    initializePreferences();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: SingleChildScrollView(
            child: Column(
              //Use AxisAlignment as Gravity
              //mainAxisAlignment is for Vertical Axis
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment is for Horizontal Axis
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("This is A TextView in Column"),
                const SizedBox(height: 10),
                const Text("The SizeBox is for Spacing"),
                const SizedBox(height: 10),
                const Text("3rd item in a Column"),
                const SizedBox(height: 10),
                const Text("4th item in a Column"),
                const SizedBox(height: 10),
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 5),
                  padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 5),
//                margin: EdgeInsets.all(20),
//                padding: EdgeInsets.all(20),
//                color: Colors.blue,
                  decoration: BoxDecoration(
//                color: Colors.blue,
                    gradient: const LinearGradient(colors: [
                      Colors.blue,
                      Colors.red,]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text("This is a TextView in Container",
                    style: TextStyle(color: Colors.white, fontSize: 15,
                        decoration: TextDecoration.underline, decorationColor: Colors.white, decorationStyle: TextDecorationStyle.double)),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("And"),
                    SizedBox(width: 3),
                    Text("This"),
                    SizedBox(width: 3),
                    Text("is"),
                    SizedBox(width: 3),
                    Text("a"),
                    SizedBox(width: 3),
                    Text("ROW"),
                  ]),
                Center(
                  child: Column(
                    children: [

                      Container(
                        width: 350,
                        child: TextField(
                          decoration: new InputDecoration(
                              hintText: "hintText"),
                        ),
                      ),

                      const SizedBox(height: 15),

                      ElevatedButton(
                          child: const Text("Move to Next Class"),
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LogOutClass()));

/*
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return LogOutClass();
                            }));
*/

                          }
                      )

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: Colors.limeAccent,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "This is Alignment\nTry to use it without Row or Column",
                      textAlign: TextAlign.center),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(txt_change),
                      const SizedBox(height: 10),
                      TextField(keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Number",
                          prefixIcon: const Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          )),
                        onChanged: (newText){
                          txt_table_number = int.parse(newText);
                        }),
                      const SizedBox(height: 10),
                      Row(
                        //MainAxisSize.max is match_parent
                        //MainAxisSize.min is wrap_content
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //Expanded is used to fill remaining space in row or column
                          Expanded(child: ElevatedButton(onPressed: (){setState(() {
                              if(setIf){
                                txt_change = "Text to be Changed";
                                setIf = false;
                              }else{
                                txt_change = "Text Changed";
                                setIf = true;
                              }
                            });},
                              child: const Text("Change Text"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                              ))),

                          Expanded(child: Container(
                              height: 35,
                              margin: const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [Colors.lightGreen, Colors.lightGreenAccent]),
                                borderRadius: BorderRadius.circular(25)),
                              child: ElevatedButton(onPressed: (){setState(() {
                                txt_table = "";
                                for(int i=1; i<=5; i++){
                                  txt_table = "$txt_table $txt_table_number * $i = ${txt_table_number*i}\n";
                                }});},
                                child: const Text("Loop"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.black,
                                )),)),
                        ]),

                      Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(child: ElevatedButton.icon(onPressed: (){
                              setState(() {
//                                initializePreferences();
                                preferences?.setString('prefToast', preferencesToast);
                              });
                              const snackbar = SnackBar(content: Text("Preferences Saved"),);
                              ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            }, label: const Text("Set Preferences", style: TextStyle(fontWeight: FontWeight.bold),),
                              icon: const Icon(Icons.favorite),
                              iconAlignment: IconAlignment.start,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.shade100,
                                  foregroundColor: Colors.white, side: const BorderSide(color: Colors.black, width: 2))),
                          ),

                          const SizedBox(width: 10),

                          Expanded(child: ElevatedButton(onPressed: (){
                              setState(() {
//                                initializePreferences();
                                UtilsClass().newToast(preferences!.getString('prefToast')!);
                              });
                            }, child: const Text("Get Preferences")),
                          ),
                        ]),

                      Row(children: [
                        Expanded(child: ElevatedButton(onPressed: () async {

                          const platform = MethodChannel('com.example.service/channel');

                          try {
                            await platform.invokeMethod('startService');
                          } on PlatformException catch (e) {
                            print("Failed to start service: ${e.message}");
                          }

                        }, child: const Text("Start Background Service"))),

                        Expanded(child: ElevatedButton(onPressed: () async {

                          const platform = MethodChannel('com.example.service/channel');

                          try {
                            await platform.invokeMethod('stopService');
                          } on PlatformException catch (e) {
                            print("Failed to stop service: ${e.message}");
                          }

                        }, child: const Text("Stop Background Service"))),

                      ],),

                      Text(txt_table),

                      TextField(onChanged: (prefText){
                        preferencesToast = prefText;
                      }, decoration: InputDecoration(
                          labelText: "Set Preferences",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          )),)
                    ]),
                ),

                RadioListTile(title: const Text("Radio A1"),
                    value: 0,
                    groupValue: rg1,
                    onChanged: (newValue){
                      setState(() {
                        rg1 = newValue!;
                      });
                    }),
                RadioListTile(title: const Text("Radio B1"),
                    value: 1,
                    groupValue: rg1,
                    onChanged: (newValue){
                      setState(() {
                        rg1 = newValue!;
                      });
                    }),

                RadioListTile(title: const Text("Radio A2"),
                    value: 0,
                    groupValue: rg2,
                    onChanged: (newValue){
                      setState(() {
                        rg2 = newValue!;
                      });
                    }),
                RadioListTile(title: const Text("Radio B2"),
                    value: 1,
                    groupValue: rg2,
                    onChanged: (newValue){
                      setState(() {
                        rg2 = newValue!;
                      });
                    }),

                CheckboxListTile(value: cb1,
                    enabled: cbe1,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    onChanged: (bool? value){
                      setState(() {
                        cb1 = value!;
                        setCheckEnabled(value);
                      });
                    },
                    title: const Text("Checkbox 1"),
                    controlAffinity: ListTileControlAffinity.leading),
                CheckboxListTile(value: cb2,
                    enabled: cbe2,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    onChanged: (bool? value){
                      setState(() {
                        cb2 = value!;
                        setCheckEnabled(value);
                      });
                    },
                    title: const Text("Checkbox 2"),
                    controlAffinity: ListTileControlAffinity.leading),
                CheckboxListTile(value: cb3,
                    enabled: cbe3,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    onChanged: (bool? value){
                      setState(() {
                        cb3 = value!;
                        setCheckEnabled(value);
                      });
                    },
                    title: const Text("Checkbox 3"),
                    controlAffinity: ListTileControlAffinity.leading),
                CheckboxListTile(value: cb4,
                    enabled: cbe4,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    onChanged: (bool? value){
                      setState(() {
                        cb4 = value!;
                        setCheckEnabled(value);
                      });
                    },
                    title: const Text("Checkbox 4"),
                    controlAffinity: ListTileControlAffinity.leading),
                CheckboxListTile(value: cb5,
                    enabled: cbe5,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    onChanged: (bool? value){
                      setState(() {
                        cb5 = value!;
                        setCheckEnabled(value);
                      });
                    },
                    title: const Text("Checkbox 5"),
                    controlAffinity: ListTileControlAffinity.leading),

                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: (){
                    if(cb1){
                      UtilsClass().newToast("True");
                    }else{
                      UtilsClass().newToast("False");
                    }
                  }, child: const Text("Get Checked")),
                ),

                Card(
                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  elevation: 7,
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                  alignment: Alignment.center,
//                  fit: StackFit.passthrough,
//                  clipBehavior: Clip.hardEdge,
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red)),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        width: 100,
                        height: 100,
                        color: Colors.green,
                      )),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue)),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.amber)),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.cyanAccent)),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.cyanAccent.shade100)),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.amber.shade100)),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white),
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: const Text("This is a Stack", textAlign: TextAlign.center)),

                  ])),

              ],)
        ),),);
  }

  Future<void> initializePreferences() async{
    preferences = await SharedPreferences.getInstance();
  }

  void setCheckEnabled(bool check) {

    if(check){
      limit++;
    }else{
      limit--;
    }

    if(limit==3){
      cbe1 = cb1;
      cbe2 = cb2;
      cbe3 = cb3;
      cbe4 = cb4;
      cbe5 = cb5;
    }else{
      cbe1 = true;
      cbe2 = true;
      cbe3 = true;
      cbe4 = true;
      cbe5 = true;
    }

  }

  Future<void> checkLogin() async{

    if(await FirebaseAuth.instance.currentUser != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LogOutClass();
      }));
    }

  }

}
