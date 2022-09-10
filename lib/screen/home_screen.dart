// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/custom/header.dart';
import 'package:timetracker/screen/target_screen.dart';
import 'package:timetracker/screen/target_screen_stream.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

var datetimenow = DateTime.now();
var datetimeformatter = DateFormat('MMM\ndd');
var datetimeformatted = datetimeformatter.format(DateTime.now());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _hourNumberPic = 1;
int _minNumberPic = 0;

Future<void> writeData(BuildContext context) async {
  var datetimenow = DateTime.now();
  var datetimeformatter = DateFormat('yyyyMMdd');
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  final database = Provider.of<Database>(context, listen: false);
  // datetimeformatted = '20220908';
  //! Use provider to connect with Database Class in service/database.dart
  try {
    //! input -> wDataModel (Fro map) -> database -> writeData
    await database.writeData(
      datetimeformatted,
      //! for create path
      writeTime(
          docid: datetimeformatted,
          thour: _hourNumberPic,
          tmin: _minNumberPic,
          chour: 0,
          cmin: 0), //! Send input data to wDataModel  to Map
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TargetScreenStream()),
    );
  } catch (e) {
    print(e.toString());
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
              gradient: RadialGradient(
            center: const Alignment(-1, -1), // near the top right
            radius: 2,
            colors: [
              Color(0xFF47985D),
              greenColor,
            ],
          )),
          child: Column(
            children: [
              CustomHearder(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CustomIconbutton(
                      color: white,
                      fontcolor: Colors.black,
                      bcolor: white,
                      bcolor2: white,
                      text: "Start",
                      fontSize: 10,
                      width: 55.w,
                      textStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 6.75.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      height: 50,
                      icon: FaIcon(FontAwesomeIcons.arrowRight,
                          size: 20, color: Colors.black),
                      onPressed: () {
                        writeData(context);
                        print("Data Saved");
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 74.h,
                    child: Stack(
                      // fit: StackFit.loose,
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 63.w,
                              height: 63.w,
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 77.w,
                              height: 77.w,
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 90.w,
                              height: 90.w,
                              decoration: BoxDecoration(
                                color: white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        WhiteBox(),
                        Positioned(
                          top: 28.w,
                          child: DateRound(),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container DateRound() {
    return Container(
      //! Date
      width: 33.w,
      height: 33.w,
      decoration: BoxDecoration(
        color: lightGreenColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          datetimeformatted,
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
                color: white, fontSize: 10.125.w, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Positioned WhiteBox() {
    return Positioned(
      top: 45.w,
      child: Container(
        width: 90.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 25.w,
            ),
            Text(
              "Select Today’s Target",
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    color: lightGreenColor,
                    fontSize: 7.5.w,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 70.w,
              // height: 25.h,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: lightGreenColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hour",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              color: white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: NumberPicker(
                          textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: white.withOpacity(0.8),
                              fontSize: 24,
                            ),
                          ),
                          selectedTextStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: white.withOpacity(0.8),
                                fontSize: 34,
                                fontWeight: FontWeight.w600),
                          ),
                          infiniteLoop: true,
                          value: _hourNumberPic,
                          minValue: 0,
                          maxValue: 24,
                          onChanged: (value) =>
                              setState(() => _hourNumberPic = value),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Min",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                              color: white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: NumberPicker(
                          textStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: white.withOpacity(0.8),
                              fontSize: 23,
                            ),
                          ),
                          selectedTextStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: white.withOpacity(0.8),
                                fontSize: 34,
                                fontWeight: FontWeight.w600),
                          ),
                          infiniteLoop: true,
                          value: _minNumberPic,
                          minValue: 0,
                          maxValue: 59,
                          onChanged: (value) =>
                              setState(() => _minNumberPic = value),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
