// ignore_for_file: depend_on_referenced_packages, avoid_print, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/alert_all.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/custom/header.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

var datetimenow = DateTime.now();
var datetimeformatter = DateFormat('MMM\ndd');
var datetimeformatted = datetimeformatter.format(DateTime.now());

class TargetScreen extends StatefulWidget {
  TargetScreen({Key? key, required this.readdata}) : super(key: key);
  WriteTime readdata;

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

int _hourNumberPic = 0;
int _minNumberPic = 0;
bool _istargetcomp = false;
Color pcolor = white;
late double targetbalance;
late AnimationController lottieController;

Future<void> writeData(BuildContext context, WriteTime readdata) async {
  int newctimemin = _minNumberPic + readdata.cmin;
  int newctimehour = _hourNumberPic + readdata.chour;
  var datetimeformatter = DateFormat('yyyyMMdd');
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  var lastupdateformatter = DateFormat('hh:mm:ss a');
  var lastupdateformatted = lastupdateformatter.format(DateTime.now());
  final database = Provider.of<Database>(context, listen: false);
  //! Use provider to connect with Database Class in service/database.dart
  final _finaltime = _minNumberPic + readdata.cmin;
  if ((_finaltime) >= 60) {
    newctimemin = newctimemin - 60;
    newctimehour = newctimehour + 1;
  }
  try {
    //! input -> wDataModel (Fro map) -> database -> writeData
    print(
        "Add ${newctimehour}.${newctimemin} to Target ${readdata.thour}.${readdata.tmin} && ");
    await database.writeData(
      datetimeformatted,
      //! for create path
      WriteTime(
          docid: datetimeformatted,
          chour: newctimehour,
          cmin: newctimemin,
          thour: readdata.thour,
          tmin: readdata.tmin,
          lastupdate:
              lastupdateformatted), //! Send input data to wDataModel  to Map
    );
  } catch (e) {
    print(e.toString());
  }
}

class _TargetScreenState extends State<TargetScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );
    lottieController.addStatusListener((status) {
      int cont = 0;
      Future.delayed(Duration(seconds: 5), () {
        // Do something
        if (status == AnimationStatus.completed) {
          cont++;
          if (cont < 5) {
            lottieController.reset();
            lottieController.forward();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WriteTime readdata = widget.readdata;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomHearder(),
              const SizedBox(
                height: 5,
              ),
              DateRound(),
              const SizedBox(
                height: 5,
              ),
              whiteBox(),
              const SizedBox(
                height: 5,
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
                  writeData(context, readdata);
                  print("Data Saved");
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
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox DateRound() {
    WriteTime readdata = widget.readdata;
    final pval = (readdata.thour + ((readdata.tmin) / 100));
    pcolor = selectpcolor();

    return SizedBox(
      width: 100.h,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
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
              )),
          targetbalance >= 100
              ? Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_obhph3sh.json',
                  width: 38.w,
                  height: 38.w,
                  controller: lottieController,
                  //
                  onLoaded: (composition) {
                    lottieController.duration = Duration(seconds: 5);
                    // lottieController.repeat(
                    //   period: Duration(seconds: 10),
                    // );
                    lottieController.forward();
                  },
                  //
                  // repeat: true,
                )
              : Container(),
        ],
      ),
    );
  }

  Stack whiteBox() {
    WriteTime readdata = widget.readdata;
    final pval = (readdata.chour + ((readdata.cmin) / 100)).toStringAsFixed(2);

    return Stack(
      children: [
        Container(
          width: 90.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(
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
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 73.w,
                height: 250,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: lightGreenColor,
                  borderRadius: const BorderRadius.all(
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
                            maxValue: 59,
                            onChanged: (value) =>
                                setState(() => _minNumberPic = value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Last Update ",
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: lightGreenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    readdata.lastupdate,
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: lightGreenColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 90.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: lightGreenColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
        Positioned(
          top: 5,
          child: Container(
            width: 90.w,
            height: 9.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 238, 238, 238),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                      readdata.cmin >= 10
                          ? " ${readdata.chour}.${readdata.cmin} h"
                          : " ${readdata.chour}.0${readdata.cmin} h",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: pcolor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color selectpcolor() {
    WriteTime readdata = widget.readdata;
    final ptval = (widget.readdata.thour + ((widget.readdata.tmin) / 100));
    final pcval = (widget.readdata.chour + ((widget.readdata.cmin) / 100));
    targetbalance = pcval / ptval * 100;
    if (targetbalance >= 100.0) {
      return Colors.amber;
    } else if (targetbalance >= 80.0) {
      return Colors.blue;
    } else if (targetbalance >= 50.0) {
      return lightGreenColor;
    } else if (targetbalance >= 30.0) {
      return Colors.orange;
    } else if (targetbalance <= 30.0) {
      return redColor;
    }
    return redColor;
  }

  double selectpval() {
    WriteTime readdata = widget.readdata;
    final ptval = (readdata.thour + ((readdata.tmin) / 100));
    final pcval = (readdata.chour + ((readdata.cmin) / 100));
    double balance = pcval / ptval;
    // if (balance >= 100 && !_istargetcomp) {}
    return balance;
  }
}
