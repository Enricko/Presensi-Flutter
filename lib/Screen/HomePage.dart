import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presensisekolah_flutter/Api/UserProfile.dart';
import 'package:presensisekolah_flutter/Screen/utils/alert.dart';
import 'package:presensisekolah_flutter/Screen/utils/login_pref.dart';
import 'package:presensisekolah_flutter/Style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api.dart';
import '../Api/PresensiPost.dart';
import '../Login.dart';
import 'Tanggal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<UserProfile>? userView;
  String? id;
  String _scanBarcode = "";

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tolong Nyalakan GPS-nya')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    if (email == null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
    var DataUser = await LoginPref.getPref();
    setState(() {
      id = DataUser.id;
    });
  }

  presensiUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var DataUser = await LoginPref.getPref();
    setState(() {
      id = DataUser.id;
    });
    if (_scanBarcode != "") {
      var dataPresensi = {
        "user_id": id!,
        "lat": _currentPosition?.latitude.toString(),
        "long": _currentPosition?.longitude.toString(),
      };
      Api.presensi(_scanBarcode, dataPresensi).then((value) {
        if (value.message! == "Berhasil di scan") {
          EasyLoading.showSuccess(value.message!, dismissOnTap: true);
        } else {
          EasyLoading.showError(value.message!, dismissOnTap: true);
        }
      }).catchError((error) {
        EasyLoading.showError(error, dismissOnTap: true);
      });
    }
  }

  @override
  void initState() {
    user().then((value) {
      userView = Api.userView(id!);
    });
    _getCurrentPosition();
    // presensiUser().then((value){
    //   Api.presensi(_scanBarcode, presensi!);
    // });
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      presensiUser();
    });
  }

  logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    print('logout');
    Alerts.showMessage("Logout Success!", context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
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
        '/' +
        data.imageProfile!;
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.black12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      GestureDetector(
                        onTap: () => scanQR(),
                        child: Image(
                          image: AssetImage('images/scan.PNG'),
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
                            child: Text(data.nisn!)),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            data.name!,
                            style: Style.h4,
                          )),
                      // Button Logout
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            logout(context);
                          },
                          child: Text('Logout'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3,
              height: 3,
              color: Colors.black,
            ),
            Tanggal(),
          ],
        ),
      ),
    );
  }
}
