import 'package:flutter/material.dart';
import 'package:presensisekolah_flutter/HomePage.dart';

void main(){
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presensi Flutter',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
