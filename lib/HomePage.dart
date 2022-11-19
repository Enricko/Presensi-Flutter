import 'package:flutter/material.dart';
import 'package:presensisekolah_flutter/Style/style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisibility = true;
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
                  controller: controllerEmail,
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
}
