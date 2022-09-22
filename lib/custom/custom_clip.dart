import 'package:flutter/material.dart';
import 'package:timetracker/custom/customcolor.dart';

class CustomClipperhead extends StatelessWidget {
  const CustomClipperhead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF007BDD),
              spreadRadius: 100,
              blurRadius: 1,
              offset: Offset(0, 7), // changes position of shadow
            ),
          ],
          color: darkBlueColor,
        ),
        // child: Center(
        //     child: Text(
        //   "Time Tracker",
        //   style: TextStyle(color: white, fontSize: 35, fontFamily: 'Raleway'),
        // ),),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
