import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:timetracker/landing_page.dart';

import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:url_launcher/url_launcher.dart';

class versionCheck extends StatefulWidget {
  const versionCheck({Key? key}) : super(key: key);

  @override
  State<versionCheck> createState() => _versionCheckState();
}

late AnimationController lottieController;

class _versionCheckState extends State<versionCheck>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );
    lottieController.addStatusListener((status) {
      int cont = 0;

      // Do something
      if (status == AnimationStatus.completed) {
        cont++;
        if (cont < 5) {
          lottieController.reset();
          lottieController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  final Uri _url = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.sstudio.timetracker");

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw 'Could not launch $_url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10),
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        center: const Alignment(-1.5, -1), // near the top right
        radius: 1.8,
        colors: [
          const Color(0xFF00EC97),
          greenColor,
        ],
      )),
      // child: Center(
      //   child: Text("aaaa"),
      // ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/warning.json',
              width: 38.w,
              height: 38.w,
              controller: lottieController,
              onLoaded: (composition) {
                lottieController.duration = Duration(seconds: 2);

                lottieController.forward();
              },
            ),
            Text(
              "New Version Found",
              style: GoogleFonts.workSans(
                textStyle: TextStyle(
                    color: white, fontSize: 8.w, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomElebutton(
              bcolor: white,
              bcolor2: const Color(0xFFC9FFEC),
              color: white,
              fontSize: 6.w,
              fontcolor: Colors.black,
              text: 'Update Now',
              width: 50.w,
              height: 6.h,
              onPressed: () {
                // _launchUrl();
              },
              textStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 6.w,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
