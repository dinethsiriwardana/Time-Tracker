import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset("assets/img/loading1.png"),
        RotationTransition(
            turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
            child: Image.asset("assets/img/loading2.png")),
        // Image.asset("assets/img/loading.png"),
      ],
    );
  }
}
