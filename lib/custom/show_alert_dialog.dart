import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';

Future<bool?> showAlertDialog(
  BuildContext context, {
  required String title,
  required String defaultActionText,
  required String content,
  String? cancelActiontext,
}) {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: lightGreenColor,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: white,
              fontSize: 6.w,
            ),
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
              color: white, fontSize: 4.w, fontStyle: FontStyle.italic),
        ),
        actions: <Widget>[
          if (cancelActiontext != null)
            TextButton(
              child: Text(cancelActiontext),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          TextButton(
            child: Text(
              defaultActionText,
              style: TextStyle(color: white, fontSize: 4.w),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(cancelActiontext!),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
