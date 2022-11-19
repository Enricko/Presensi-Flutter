import 'package:flutter/material.dart';
import 'package:presensisekolah_flutter/Style/style.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisibility = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

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
                        // login(context);
                      },
                      child: Text(
                        'Login',
                        style: Style.h5,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => RegisterPage(),
                    //   ),
                    // );
                  },
                  child: Text("Don`t have an account? create here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
