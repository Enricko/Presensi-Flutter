import 'package:flutter/material.dart';
import 'package:presensisekolah_flutter/Login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screen/HomePage.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email=prefs.getString("email");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Presensi Flutter',
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
    builder: EasyLoading.init(),
    home: email==null?Login():HomePage()));
}
