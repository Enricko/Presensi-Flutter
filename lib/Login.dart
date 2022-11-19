import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:presensisekolah_flutter/Style/style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Api/Api.dart';
import 'Screen/HomePage.dart';
import 'Screen/utils/alert.dart';
import 'Screen/utils/login_pref.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisibility = true;
  String _errorMessage = '';
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  login(BuildContext context){
    var email = controllerEmail.text;
    var password = controllerPassword.text;
    if(email.isEmpty && password.isEmpty){
      EasyLoading.showError('Please insert Email & Password',dismissOnTap: true);
      return;
    }else{
      if (email.isEmpty) {
        EasyLoading.showError('Please insert Email',dismissOnTap: true);
        return;
      }
      if (password.isEmpty) {
        EasyLoading.showError('Please insert Password',dismissOnTap: true);
        return;
      }
    }
    var data = {
      "email": email,
      "password": password,
    };
    Api.submitLogin(data).then(
          (value) async {
        //ketika pesan nya bukan successful
        // print(value);
        if (value.message != "success") {
          //muncul error
          await EasyLoading.showError('Email or Password is incorrect',dismissOnTap: true);
          return;
        }
        LoginPref.saveToSharedPref(
          value.data!.id!.toString(),
          value.data!.name!,
          value.data!.email!,
        );

        //cek apakah pref yang sudah di save, benar benar tersimpan?
        if (await LoginPref.checkPref() == true) {
          Alerts.showMessage("Login Success!", context);
          //jika ya,maka kembali kehalaman semula
          Navigator.of(context).pop();

          //iduser dan username tampil di console
          LoginPref.getPref().then((value) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomePage())
            );
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Login",
                    style: Style.h2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerEmail,
                  onChanged: (val){
                    setState(() {
                      validateEmail(val);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                if (_errorMessage != '')
                Padding(
                  padding: const EdgeInsets.only(top:3),
                  child: Text(_errorMessage, style: TextStyle(color: Colors.red),),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerPassword,
                  obscureText: isVisibility,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Password",
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: isVisibility == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          // Memeberikan nilai pada variable isVisibility
                          // dengan nilai balikan dari nilai is inVisibility sebelumnya
                          isVisibility = !isVisibility;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: Text(
                        'Login',
                        style: Style.h5,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    }else{
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
