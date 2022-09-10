import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:timetracker/service/firebase/auth.dart';

class CustomHearder extends StatefulWidget {
  const CustomHearder({Key? key}) : super(key: key);

  @override
  State<CustomHearder> createState() => _CustomHearderState();
}

class _CustomHearderState extends State<CustomHearder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 100,
      width: 100.w,
      decoration: BoxDecoration(
          color: white.withOpacity(0.2),
          borderRadius: new BorderRadius.only(
            bottomLeft: const Radius.circular(20.0),
            bottomRight: const Radius.circular(20.0),
          )),
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
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: DropdownButtonHideUnderline(
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
            ),
          )
        ],
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
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
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
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.logout:
        final auth = Provider.of<AuthBase>(context, listen: false);
        auth.signOut();
        break;
    }
  }
}
