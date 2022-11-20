import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:presensisekolah_flutter/Api/Api.dart';
import 'package:presensisekolah_flutter/Screen/utils/login_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/PresensiList.dart';
import '../Login.dart';


class Tanggal extends StatefulWidget {
  const Tanggal({Key? key}) : super(key: key);

  @override
  State<Tanggal> createState() => _TanggalState();
}

class _TanggalState extends State<Tanggal> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  //  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      // new DateTime(2022,11,11): [
      //   new Event(
      //     date: new DateTime(2019, 2, 10),
      //     title: 'Event 1',
      //     icon: _eventIcon,
      //     dot: Container(
      //       margin: EdgeInsets.symmetric(horizontal: 1.0),
      //       color: Colors.red,
      //       height: 5.0,
      //       width: 5.0,
      //     ),
      //   ),
      //   new Event(
      //     date: new DateTime(2022, 11, 11),
      //     title: 'Event 2',
      //     icon: _eventIcon,
      //   ),
      //   new Event(
      //     date: new DateTime(2019, 2, 10),
      //     title: 'Event 3',
      //     icon: _eventIcon,
      //   ),
      // ],
    },
  );
  List<Data> listPresensi = [];

  String? id;

  Future user() async{
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
  @override
  void initState() {
    user().then((value) {
      Api.presensiList(id!).then((value) {
        setState(() {
          listPresensi = value.data!;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: CalendarCarousel<Event>(
              // onDayPressed: (DateTime date, List<Event> events) {
              //   this.setState(() => _currentDate = date);
              // },
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              thisMonthDayBorderColor: Colors.grey,
              //      weekDays: null, /// for pass null when you do not want to render weekDays
              //      headerText: Container( /// Example for rendering custom header
              //        child: Text('Custom Header'),
              //      ),
              customDayBuilder: (
                  /// you can provide your own build function to make custom day containers
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                  ) {
                /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                /// This way you can build custom containers for specific days only, leaving rest as default.

                // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                // listPresensi.forEach((element) {
                //   if(){
                //
                //   }
                // });

                if (DateFormat('yyyy-MM-dd').format(day) == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                  print(DateFormat('yyyy-MM-dd').format(day) == DateFormat('yyyy-MM-dd').format(DateTime.parse('2022-11-19')));
                  return Center(
                    child: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                  );
                } else {
                  for(var i = 0; i < listPresensi.length; i++) {
                    if(DateFormat('yyyy-MM-dd').format(day) == DateFormat('yyyy-MM-dd').format(DateTime.parse(listPresensi[i].createdAt!))){
                      if(listPresensi[i].status == 'hadir'){
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.green
                          ),
                          child: Center(
                            child: Text(
                              "${day.day}",
                              style: TextStyle(
                                  color:Colors.black
                              ),
                            ),
                          ),
                        );
                      }
                      if(listPresensi[i].status == 'izin'){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow
                          ),
                          child: Center(
                            child: Text(
                              "${day.day}",
                              style: TextStyle(
                                color:Colors.black
                              ),
                            ),
                          ),
                       );
                      }
                      if(listPresensi[i].status == 'alpha' && listPresensi[i].status == 'bolos'){
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent
                          ),
                          child: Center(
                            child: Text(
                              "${day.day}",
                              style: TextStyle(
                                  color:Colors.black
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  };
                  return null;
                }
              },
              weekFormat: false,
              markedDatesMap: _markedDateMap,
              height: 420.0,
              selectedDateTime: _currentDate,
              daysHaveCircularBorder: false,

              /// null for not rendering any border, true for circular border, false for rectangular border
            ),
          ),
        // SizedBox(
        //   height: 200,
        //   child: ListView.builder(
        //     physics: NeverScrollableScrollPhysics(),
        //     itemCount: 8,
        //     itemBuilder: (BuildContext context, index){
        //       print(listPresensi);
        //       return Text(listPresensi[index].time!);
        //     }
        //   ),
        // )
      ],
    );
  }
}
