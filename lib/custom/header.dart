import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:timetracker/landing_page.dart';
import 'package:timetracker/screen/home_screen/home_screen.dart';
import 'package:timetracker/screen/show_log/log_screen.dart';
import 'package:timetracker/screen/show_log/log_stream.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/get/firebase_get.dart';

class CustomHearder extends StatefulWidget {
  CustomHearder({Key? key, required this.hloc}) : super(key: key);
  String hloc;
  @override
  State<CustomHearder> createState() => _CustomHearderState();
}

final GetController getController = Get.put(GetController());

class _CustomHearderState extends State<CustomHearder> {
  void test() {}
  @override
  Widget build(BuildContext context) {
    bool isbool = true;
    void test1() {}

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 100,
      width: 100.w,
      decoration: BoxDecoration(
        color: white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.0
            // bottomLeft: Radius.circular(20.0),
            // bottomRight: Radius.circular(20.0),
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Time Tracker",
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                      color: white,
                      fontSize: 10.125.w,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "JUST COMPLETE IT",
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                    color: white,
                    fontSize: 5.w,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: dropdown(context),
          )
        ],
      ),
    );
  }

  DropdownButtonHideUnderline dropdown(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          FontAwesomeIcons.userLarge,
          size: 25,
          color: white,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          // const DropdownMenuItem<Divider>(
          //     enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 140,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGreenColor,
        ),
        dropdownElevation: 8,
        offset: const Offset(-90, -10),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, log, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const log = MenuItem(text: 'Log', icon: Icons.receipt_long);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    logout() {
      deletedata() async {
        final auth = Provider.of<AuthBase>(context, listen: false);
        auth.signOut(context);
        auth.authStateChanges();
      }

      try {
        // QuickAlert.show(
        //     context: context,
        //     type: QuickAlertType.success,
        //     title: 'Do you want to logout',
        //     text: 'This Box will closed within 5 sec',
        //     confirmBtnText: 'Yes',
        //     confirmBtnColor: lightGreenColor,
        //     showCancelBtn: false,
        //     onConfirmBtnTap: () {
        //       // Navigator.pop(context);
        //       Future.delayed(Duration(seconds: 5), () {
        deletedata();
        //         // Do something
        //       });
        //     },
        //     autoCloseDuration: Duration(seconds: 5));
      } catch (e) {
        print(e.toString());
      }
    }

    gotoLog() {}

    switch (item) {
      case MenuItems.home:
        Navigator.pop(context);

        break;
      case MenuItems.settings:
        break;
      case MenuItems.log:
        // return MaterialApp(
        //   home: LogScreen(),
        //   debugShowCheckedModeBanner: false,
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogScreen()),
        );
        break;
      case MenuItems.logout:
        // Navigator.pop(context);

        logout();
        break;
    }
  }
}
