import 'package:shared_preferences/shared_preferences.dart';

import 'data_user.dart';

class LoginPref {
  static Future<bool> saveToSharedPref(String id, String name, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("id", id);
    pref.setString("name", name);
    pref.setString("email", email);
    return true;
  }

  //cek apakah user memiliki preference sengan key "id"
  static Future<bool> checkPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //jika ada maka bernilai true, jika tidak maka bernilai false
    bool status = pref.containsKey("id");

    return status;
  }
  //cara untuk mengambil nilai pref
  static Future <DataUser> getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    DataUser dataUser = DataUser();
    dataUser.id = pref.getString("id");
    dataUser.name = pref.getString("name");
    dataUser.email = pref.getString("email");
    return dataUser;
  }

  static Future<bool> removePref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    return true;
  }
}