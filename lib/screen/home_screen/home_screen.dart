// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/custom/header.dart';
import 'package:timetracker/debugLog/debugcolor.dart';
import 'package:timetracker/screen/target_screen/target_screen_stream.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

var datetimenow = DateTime.now();
var datetimeformatter = DateFormat('MMM\ndd');
var datetimeformatted = datetimeformatter.format(DateTime.now());

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.autothour, required this.autotmin})
      : super(key: key);
  final int autothour;
  final int autotmin;

  @override
  State<HomePage> createState() => _HomePageState();
}

int _hourNumberPic = 1;
int _minNumberPic = 0;
bool _isselectauto = true;

Future<void> writeData(BuildContext context, autothour, autotmin) async {
  var datetimeformatter = DateFormat('yyyyMMdd');
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  var lastupdateformatter = DateFormat('hh:mm:ss a');
  var lastupdateformatted = lastupdateformatter.format(DateTime.now());
  print(lastupdateformatted);
  final database = Provider.of<Database>(context, listen: false);
  // datetimeformatted = '20220908';
  //! Use provider to connect with Database Class in service/database.dart
  try {
    // ! input -> wDataModel (Fro map) -> database -> writeData
    await database.writeData(
      datetimeformatted,
      //! for create path
      WriteTime(
          docid: datetimeformatted,
          thour: _isselectauto ? _hourNumberPic : autothour,
          tmin: _isselectauto ? _minNumberPic : autotmin,
          chour: 0,
          cmin: 0,
          lastupdate:
              lastupdateformatted), //! Send input data to wDataModel  to Map
    );
  } catch (e) {
    print(e.toString());
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    (widget.autothour != 0 || widget.autotmin != 0)
        ? logSuccess(
            "Enable Auto Target | Target ${widget.autothour}:${widget.autotmin}")
        : logSuccess("Disable Auto Target");
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
              const Color(0xFF47985D),
              greenColor,
            ],
          )),
          child: Column(
            children: [
              CustomHearder(
                hloc: 'HomePage',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
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
                      icon: const FaIcon(FontAwesomeIcons.arrowRight,
                          size: 20, color: Colors.black),
                      onPressed: () {
                        writeData(context, widget.autothour, widget.autotmin);
                        print("Data Saved");
                      }),
                  const SizedBox(
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
                        whiteBox(),
                        Positioned(
                          top: 28.w,
                          child: dateRound(),
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

  Container dateRound() {
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

  Positioned whiteBox() {
    return Positioned(
      top: 45.w,
      child: Container(
        width: 90.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20.w,
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
            const SizedBox(
              height: 17,
            ),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: 70.w,
                  height: 28.h,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGreenColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                      topRight: Radius.circular(
                          (widget.autothour != 0 || widget.autotmin != 0)
                              ? 0
                              : 50),
                    ),
                  ),
                  child: (_isselectauto) ? manualtimeset() : autotimeset(),
                ),
                (widget.autothour != 0 || widget.autotmin != 0)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            print(_isselectauto);
                            _isselectauto = !_isselectauto;
                          });
                        },
                        child: Container(
                          //! Date
                          width: 9.w,
                          height: 9.w,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _isselectauto ? "A" : "M",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.workSans(
                                textStyle: TextStyle(
                                    color: lightGreenColor,
                                    fontSize: 7.w,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox autotimeset() {
    return SizedBox(
      height: 28.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Today’s Targert\nFor You",
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
              textStyle: TextStyle(
                  color: white, fontSize: 7.5.w, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (widget.autothour) <= 9
                    ? "0${widget.autothour}"
                    : widget.autothour.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white,
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                ":",
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white,
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                (widget.autothour) <= 9
                    ? "0${widget.autotmin}"
                    : widget.autotmin.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white,
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                " h",
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white,
                      fontSize: 15.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row manualtimeset() {
    return Row(
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
                    color: white, fontSize: 35, fontWeight: FontWeight.bold),
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
                onChanged: (value) => setState(() => _hourNumberPic = value),
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
                    color: white, fontSize: 35, fontWeight: FontWeight.bold),
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
                onChanged: (value) => setState(() => _minNumberPic = value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
