import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlmain/functions/sqflitefunctions.dart';

int? passingindex;

class Showingdetails extends StatefulWidget {
  const Showingdetails({super.key});

  @override
  State<Showingdetails> createState() => _ShowingdetailsState();
}

class _ShowingdetailsState extends State<Showingdetails> {
  File? image;
  @override
  Widget build(BuildContext context) {
    var model = detailsnotifier.value[passingindex!];

    void pickimage() async {
      var pickedimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedimage != null) {
        setState(() {
          image = File(pickedimage.path);
        });
      } else {
        print("no image");
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 199, 236),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Student Details",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            backgroundImage: image != null ? FileImage(image!) : null,
            radius: 70,
            child: image == null
                ? IconButton(
                    onPressed: () {
                      pickimage();
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      size: 60,
                    ))
                : null,
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Name : ${model["name"]}",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Age : ${model["age"]}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "From : ${model["place"]}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Phone No : ${model["phonenumber"]}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.blue.shade100)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"))
        ],
      )),
    );
  }
}
