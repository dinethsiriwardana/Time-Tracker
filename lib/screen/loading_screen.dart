import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
          gradient: RadialGradient(
        center: const Alignment(-1.5, -1), // near the top right
        radius: 1.8,
        colors: [
          Color(0xFF00EC97),
          greenColor,
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset("assets/img/loading1.png"),
              RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
                  child: Image.asset("assets/img/loading2.png")),
              // Image.asset("assets/img/loading.png"),
            ],
          ),
          Text("Time Tracker",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: white,
                    fontSize: 10.125.w,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    ));
  }
}
