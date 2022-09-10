// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/custom/header.dart';
import 'package:timetracker/screen/target_screen_stream.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

var datetimenow = DateTime.now();
var datetimeformatter = DateFormat('MMM\ndd');
var datetimeformatted = datetimeformatter.format(DateTime.now());

class TargetScreen extends StatefulWidget {
  TargetScreen({Key? key, required this.readdata}) : super(key: key);
  writeTime readdata;

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

int _hourNumberPic = 0;
int _minNumberPic = 0;

Future<void> writeData(BuildContext context, writeTime readdata) async {
  int _newctimemin = _minNumberPic + readdata.cmin;
  int _newctimehour = _hourNumberPic + readdata.chour;
  var datetimenow = DateTime.now();
  var datetimeformatter = DateFormat('yyyyMMdd');
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  final database = Provider.of<Database>(context, listen: false);
  //! Use provider to connect with Database Class in service/database.dart
  if ((_minNumberPic + readdata.tmin) >= 60) {
    _newctimemin = _newctimemin - 60;
    _newctimehour = _newctimehour + 1;
  }
  print("Add Time = ");
  try {
    //! input -> wDataModel (Fro map) -> database -> writeData
    await database.writeData(
      datetimeformatted,
      //! for create path
      writeTime(
          docid: datetimeformatted,
          chour: _newctimehour,
          cmin: _newctimemin,
          thour: readdata.thour,
          tmin: readdata.tmin), //! Send input data to wDataModel  to Map
    );
  } catch (e) {
    print(e.toString());
  }
}

class _TargetScreenState extends State<TargetScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    writeTime readdata = widget.readdata;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomHearder(),
              SizedBox(
                height: 10,
              ),
              DateRound(),
              SizedBox(
                height: 10,
              ),
              WhiteBox(),
              SizedBox(
                height: 10,
              ),
              CustomElebutton(
                bcolor: white,
                bcolor2: white,
                color: white,
                fontSize: 9.w,
                fontcolor: Colors.black,
                text: 'ADD',
                width: 50.w,
                height: 8.h,
                onPressed: () {
                  print("Data Saved");

                  writeData(context, readdata);
                  _hourNumberPic = 0;
                  _minNumberPic = 0;
                  setState(() {});
                },
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: greenColor,
                    fontSize: 6.75.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container DateRound() {
    writeTime readdata = widget.readdata;
    final pval = (readdata.thour + ((readdata.tmin) / 100)).toStringAsFixed(2);
    Color pcolor = selectpcolor();
    print(pval);
    return Container(
        //! Date
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: lightGreenColor,
          shape: BoxShape.circle,
        ),
        child: LiquidCircularProgressIndicator(
          value: selectpval(), // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(
            pcolor,
          ),
          backgroundColor: darkBlueColor,
          borderColor: white,
          borderWidth: 7.0,
          direction: Axis.vertical,
          center: Center(
            child: Text(
              "Target\n$pval h",
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                  color: white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }

  Stack WhiteBox() {
    writeTime readdata = widget.readdata;
    final pval = (readdata.chour + ((readdata.cmin) / 100)).toStringAsFixed(2);

    return Stack(
      children: [
        Container(
          width: 90.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Add To Today’s Target",
                textAlign: TextAlign.center,
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: lightGreenColor,
                      fontSize: 7.5.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 70.w,
                // height: 25.h,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: lightGreenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
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
                            value: _minNumberPic,
                            minValue: 0,
                            maxValue: 60,
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
        Container(
          width: 90.w,
          height: 9.h,
          decoration: BoxDecoration(
            color: lightGreenColor,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
        Positioned(
          top: 5,
          child: Container(
            width: 90.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 238, 238, 238),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "For Now",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: lightGreenColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    " $pval h",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: lightGreenColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color selectpcolor() {
    writeTime readdata = widget.readdata;
    final ptval = (readdata.thour + ((readdata.tmin) / 100));
    final pcval = (readdata.chour + ((readdata.cmin) / 100));
    double balance = pcval / ptval * 100;
    print("$pcval / $ptval = $balance");
    if (balance >= 100.0) {
      return Colors.amber;
    } else if (balance >= 80.0) {
      return Colors.blue;
    } else if (balance >= 50.0) {
      return lightGreenColor;
    } else if (balance >= 30.0) {
      return Colors.orange;
    } else if (balance <= 30.0) {
      return redColor;
    }
    return redColor;
  }

  double selectpval() {
    writeTime readdata = widget.readdata;
    final ptval = (readdata.thour + ((readdata.tmin) / 100));
    final pcval = (readdata.chour + ((readdata.cmin) / 100));
    double balance = pcval / ptval;
    return balance;
  }
}
