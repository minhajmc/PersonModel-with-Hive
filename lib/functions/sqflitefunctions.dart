import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlmain/models/studentmodel.dart';

late Database db;
ValueNotifier<List<Map>> detailsnotifier = ValueNotifier([]);

//database initializing
Future<void> initDataBase() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age INTEGER,place TEXT,phonenumber INTEGER,)');
    },
  );
  getData();
}

//dataadding method

Future<void> insertData(Studentmodel model) async {
  await db.rawInsert(
      'INSERT INTO student (name,age,place,phonenumber) VALUES(?,?,?,?)',
      [model.name, model.age, model.place, model.phonenumber]);
 
  getData();
}
//getdata method

Future<void> getData() async {
  detailsnotifier.value = await db.rawQuery('SELECT * FROM student');
  print(detailsnotifier);
}

//delete method
Future<void> deleteData(int id) async {
  await db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  getData();
}

//updating method

Future<void> updateData(
    BuildContext context, Studentmodel model, int id) async {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();

  namecontroller.text = model.name;
  agecontroller.text = model.age.toString();
  placecontroller.text = model.place;
  phonenumbercontroller.text = model.phonenumber.toString();

  void checkChange() async {
    if (namecontroller.text != model.name ||
        agecontroller.text != model.age.toString() ||
        placecontroller.text != model.place ||
        phonenumbercontroller.text != model.phonenumber.toString()) {
      db.rawUpdate(
          'UPDATE student SET name = ?,age = ?,place = ?, phonenumber = ? WHERE id = ?',
          [
            namecontroller.text,
            agecontroller.text,
            placecontroller.text,
            phonenumbercontroller.text,
            id
          ]);
          getData();
    }

    
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 500,
          child: Column(
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
                height: 10,
              ),
              TextField(
                maxLength: 2,
                controller: agecontroller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Age",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 3)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLength: 16,
                controller: placecontroller,
                decoration: InputDecoration(
                  hintText: "Enter Place",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 3)),
                ),
              ),
              SizedBox(
                height: 10,
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
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    checkChange();
                    Navigator.pop(context);
                  },
                  child: Text("Edit")),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back")),
            ],
          ),
        ),
      );
    },
  );
}
