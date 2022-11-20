import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:presensisekolah_flutter/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _SplashScreenBody(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class _SplashScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenBodyState();
  }
}

class _SplashScreenBodyState extends State<_SplashScreenBody> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => mains()),
      //         (Route route) => false);
      mains();
    });
    return Scaffold(
      body: Center(
          child: Image(
            image: AssetImage("images/smk.png"),
            height: 75.0,
            width: 75.0,
          )),
    );
  }
}
