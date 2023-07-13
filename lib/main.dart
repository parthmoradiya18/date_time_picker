import 'package:date_time_picker/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Home(),));
}

class Home extends StatefulWidget {
  String ?id;
  Map ?m;
  Home([this.id,this.m]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();
 // TextEditingController t5=TextEditingController();

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if(widget.id!=null)
    {
      t1.text=widget.m!['name'];
      t2.text=widget.m!['contact'];
      t3.text=widget.m!['marks']['email'];
      t4.text=widget.m!['marks']['date'];
      // t5.text=widget.m!['marks']['password'];

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("date_time_picker"),),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(margin: EdgeInsets.all(5),color: Colors.grey,child: TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Name",labelText: "Enter Name"),)),
          Card(margin: EdgeInsets.all(5),color: Colors.grey,child: TextField(controller: t2,decoration: InputDecoration(hintText: "Enter Contact",labelText: "Enter Contact"))),
          Card(margin: EdgeInsets.all(5),color: Colors.grey,child: TextField(controller: t3,decoration: InputDecoration(hintText: "Enter Email",labelText: "Enter Email"))),

          Card(margin: EdgeInsets.all(5),color: Colors.grey,
            child: TextField(decoration: InputDecoration(hintText: "Enter DATE",labelText: "Enter DATE"),controller: t4,
              onTap: () {
                showDatePicker(context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1949),
                  lastDate: DateTime(2025),
                ).then((value) {
                  var month=DateFormat("MM").format(value!);
                  var day=DateFormat("d").format(value!);
                  var year=DateFormat("yyyy").format(value!);
                  String date=month+"/"+day+"/"+year;
                  t4.text=date;
                });

              },
            ),
          ),
   //     Card(margin: EdgeInsets.all(5),color: Colors.grey,child: TextField(controller: t5,decoration: InputDecoration(hintText: "Enter Password",labelText: "Enter Password"))),
          ElevatedButton(onPressed: () async {
            if(widget.id!=null)
            {
              DatabaseReference ref = FirebaseDatabase.instance.ref("student").child(widget.id!);

              await ref.update({
                "name": "${t1.text}",
                "contact": "${t2.text}",
                "marks": {
                  "email": "${t3.text}",
                  "date": "${t4.text}",
                  // "password": "${t5.text}",

                }
              });
            }
            else
            {

              DatabaseReference ref = FirebaseDatabase.instance.ref("student").push();

              await ref.set({
                "name": "${t1.text}",
                "contact": "${t2.text}",
                "marks": {
                  "email": "${t3.text}",
                  "date": "${t4.text}",
                  //"passwrod": "${t5.text}",

                }
              });
            }
          }, child: Text("submit")),

          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return view();
            }));
          }, child: Text("View")),

        ],),
      ),
    );
  }
}
