import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:presensisekolah_flutter/Api/PresensiPost.dart';
import 'package:presensisekolah_flutter/Api/UserProfile.dart';
import 'LiburList.dart';
import 'LoginUser.dart';
import 'PresensiList.dart';

const TOKEN = "kfTwUgyexvNu8fRjZ7dmzX43O3k8D9ifpDs1bn3lpuqaYiCd1O";
const BASE_URL = "https://presensi.enricko.com/api/";

class Api{
  static Future<LoginUser> submitLogin(Map<String,String>data)async{
    var url = BASE_URL + "loginuser?token="+ TOKEN +"&email=${data['email']}&password=${data['password']}";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // return response.body;
      return LoginUser.fromJson(jsonDecode(response.body));
    } else {
      throw url;
    }
  }
  static Future<UserProfile> userView(String id)async{
    var url = BASE_URL + "user/${id}?token="+ TOKEN ;
    final response = await http.get(Uri.parse(url));
    // Cek apakah kode status adalah 200,200 artinya OK
    if(response.statusCode == 200){
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    // Jika error,maka kembalikan pesan error seperti di bawah ini
    throw "Gagal mengambil data user";
  }
  static Future<PresensiList> presensiList(String id) async {
    var url = BASE_URL + "presensi/${id}?token="+ TOKEN ;
    final response = await http.get(Uri.parse(url));
    // Cek apakah kode status adalah 200,200 artinya OK
    if(response.statusCode == 200){
      return PresensiList.fromJson(jsonDecode(response.body));
    }
    // Jika error,maka kembalikan pesan error seperti di bawah ini
    throw "Gagal mengambil data user";
  }
  static Future<LiburList> liburList() async {
    var url = BASE_URL + "liburs?token="+ TOKEN ;
    final response = await http.get(Uri.parse(url));
    // Cek apakah kode status adalah 200,200 artinya OK
    if(response.statusCode == 200){
      return LiburList.fromJson(jsonDecode(response.body));
    }
    // Jika error,maka kembalikan pesan error seperti di bawah ini
    throw "Gagal mengambil data user";
  }
  static Future<PresensiPost> presensi(String qr,Map<String,String?>dataPresensi) async {
    final response = await http.post(
      Uri.parse("${qr}/android"),
      body: dataPresensi,
    );
    if(response.statusCode == 200){
      print('berhasil');
      return PresensiPost.fromJson(jsonDecode(response.body));
    }
    // Jika error,maka kembalikan pesan error seperti di bawah ini
    throw "Something went Wrong";
  }
}