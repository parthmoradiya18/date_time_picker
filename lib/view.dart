import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List key=[];
  List value=[];

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref("student");
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m=data as Map;
      key =m.keys.toList();
      value=m.values.toList();

      setState(() {
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("view"),

        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Home();
            }));
          }, icon: Icon(Icons.home)),
        ],),
      body: ListView.builder(itemCount: value.length,

        itemBuilder: (BuildContext context, int index) {
          return Card(margin: EdgeInsets.all(5),color: Colors.grey,
            child: ListTile(
              title: Text("${value[index]['name']} \n ${value[index]['contact']}"),
              //subtitle: Text("${value[index]['marks']['email']}|${value[index]['marks']['date']}|${value[index]['marks']['password']}|"),
              subtitle: Text("${value[index]['marks']['email']}\n${value[index]['marks']['date']}"),

              trailing: Wrap(children: [
                IconButton(onPressed: () {
                  DatabaseReference ref = FirebaseDatabase.instance.ref("student").child(key[index]);
                  ref.remove();
                  setState(() {
                  });

                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Home(key[index],value[index]);
                  }));
                }, icon: Icon(Icons.edit)),

              ],),
            ),
          );
        },),
    );
  }
}
