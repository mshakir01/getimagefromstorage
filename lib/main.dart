import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getdatafirebasestorage/homeScreen.dart';

import 'getData.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the ro2ot of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const GetDataScreen(),
    );
  }
}

