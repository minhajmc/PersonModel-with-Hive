import 'package:flutter/material.dart';
import 'package:sqlmain/functions/sqflitefunctions.dart';
import 'package:sqlmain/models/studentmodel.dart';
import 'package:sqlmain/screens/floatingbutton.dart';
import 'package:sqlmain/screens/showingdetails.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDataBase();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade100,
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Floatbutton(),
                  ));
            }),
        body: ValueListenableBuilder(
          valueListenable: detailsnotifier,
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final details = value[index];
                return Card(
                  color: Colors.blue.shade100,
                  child: ListTile(
                    onTap: () {
                   
                      passingindex=index;
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Showingdetails();
                        
                      },));
                    },
                    title: Text("${details['name']}",style: TextStyle(fontSize: 20,color: Colors.black),),
                    subtitle: Text("${details['age']}",style: TextStyle(fontSize: 15,color: Colors.black),),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          updateData(context, Studentmodel(name:details['name'], age: details['age'], place: details['place'], phonenumber: details['phonenumber']),details['id']);
                        }, icon: Icon(Icons.edit,color: Colors.blue,)),
                         IconButton(onPressed: (){
                          deleteData(details['id']);
                         }, icon: Icon(Icons.delete,color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
