import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:presensisekolah_flutter/Api/UserProfile.dart';
import 'package:presensisekolah_flutter/Screen/utils/alert.dart';
import 'package:presensisekolah_flutter/Screen/utils/login_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api.dart';
import '../Login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UserProfile>? userView;
  String? id;
  String _scanBarcode = 'Unknown';

  Future user() async {
    var DataUser = await LoginPref.getPref();
    setState(() {
      id = DataUser.id;
    });
  }

  @override
  void initState() {
    user().then((value) {
      userView = Api.userView(id!);
    });
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    print('logout');
    Alerts.showMessage("Logout Success!", context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xeb00003d), Color(0xfc0a0a77)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
                future: userView,
                builder: (context, AsyncSnapshot<UserProfile> snapshot) {
                  if (snapshot.hasData) {
                    return Profile(context, snapshot.data!.data!);
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Somethink wrong ${snapshot.error}"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Container Profile(BuildContext context, Data data) {
    var image_default = "https://presensi.enricko.com/assets/image/user.png";
    var image_baseUrl = "https://presensi.enricko.com/image/profile/" +
        data.level! +
        data.imageProfile!;
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    data.imageProfile! == null
                        ? "${image_default}"
                        : "${image_baseUrl}",
                    height: 100,
                    width: 100,
                    loadingBuilder: (context, obj, stacktrace) {
                      if (stacktrace == null) {
                        return obj;
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, obj, stacktrace) {
                      return Image.network(
                        "${image_default}",
                        height: 100,
                        width: 100,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              GestureDetector(
                onTap: () => scanQR(),
                child: Image.network(
                  'https://cdn.osxdaily.com/wp-content/uploads/2022/04/qr-code-example.jpg',
                  height: 100,
                  width: 100,
                  loadingBuilder: (context, obj, stacktrace) {
                    if (stacktrace == null) {
                      return obj;
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              // ElevatedButton(
              //     onPressed: () => scanQR(),
              //     child: Text('Start QR scan')
              // ),
            ],
          ),
          if (data.level! == 'siswa')
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(data.nisn!)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(data.name!)
              ),
              // Button Logout
              Container(
                margin: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: (){
                    logout(context);
                  },
                  child: Text('Logout'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

