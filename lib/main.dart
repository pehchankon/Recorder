import 'package:flutter/material.dart';
import 'record_button.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF171717),
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        //appBar: AppBar(title: const Text('Hello'),backgroundColor: Colors.red,),
        body: Center(
          child: RecordButton(),
        ),
      ),
    );
  }
}




