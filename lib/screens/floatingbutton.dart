import 'package:flutter/material.dart';
import 'package:sqlmain/functions/sqflitefunctions.dart';
import 'package:sqlmain/models/studentmodel.dart';

class Floatbutton extends StatelessWidget {
  Floatbutton({super.key});
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  maxLength: 16,
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLength: 2,
                  controller: agecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Age",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLength: 20,
                  controller: placecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Place",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLength: 10,
                 
                  controller: phonenumbercontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter PhoneNumber",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      validcheck(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepOrange),
                      fixedSize: WidgetStatePropertyAll(
                        Size(150, 50),
                      ),
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                      SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.green),
                      fixedSize: WidgetStatePropertyAll(
                        Size(150, 50),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              ],
            ),
          ),
        ));
  }

  void validcheck(BuildContext context) {
    if (namecontroller.text.isNotEmpty &&
        agecontroller.text.toString().isNotEmpty &&
        placecontroller.text.isNotEmpty &&
        phonenumbercontroller.text.toString().isNotEmpty) {
      Studentmodel model = Studentmodel(
          name: namecontroller.text,
          age: int.parse(agecontroller.text),
          place: placecontroller.text,
          phonenumber: int.parse(phonenumbercontroller.text));
      insertData(model);
      Navigator.pop(context);
    }else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red.shade700,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      content: Text("Must Fill All Columns")));
    }
  }
}
