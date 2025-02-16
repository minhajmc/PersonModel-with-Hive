import 'package:flutter/material.dart';
import 'package:sqlmain/functions/sqflitefunctions.dart';
import 'package:sqlmain/screens/viewscreen.dart';

void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDataBase();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),));
}