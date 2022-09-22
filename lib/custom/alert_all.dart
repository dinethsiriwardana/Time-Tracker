import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:timetracker/custom/customcolor.dart';

targetcomplete(context) {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to logout',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: lightGreenColor,
      showCancelBtn: false,
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
      onConfirmBtnTap: () {
        Navigator.pop(context);
      });
}
