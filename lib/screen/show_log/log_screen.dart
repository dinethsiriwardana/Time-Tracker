import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/header.dart';
import 'package:timetracker/screen/show_log/log_stream.dart';

import '../../custom/customcolor.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-1, -1), // near the top right
            radius: 2,
            colors: [
              const Color(0xFF47985D),
              greenColor,
            ],
          ),
          // color: white,
        ),
        child: SafeArea(
            bottom: false,
            left: true,
            // top: true,
            right: true,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.zero,
            child: Scaffold(
              body: Container(
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
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHearder(
                      hloc: 'LogScreen',
                    ),
                    Container(
                      height: 75.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: white.withOpacity(0.2),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7.w,
                            ),
                            Container(
                              height: 8.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: white.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  "All Targets",
                                  style: GoogleFonts.workSans(
                                    textStyle: TextStyle(
                                        color: white,
                                        fontSize: 11.w,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 57.h,
                              child: LogScreenStream(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
