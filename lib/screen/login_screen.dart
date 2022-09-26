// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/custom_button.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:intl/intl.dart';
import 'package:timetracker/custom/show_exception_alert_dialog.dart';
import 'package:timetracker/landing_page.dart';
import 'package:timetracker/service/firebase/auth.dart';

var datetimenow = DateTime.now();
var datetimeformatter = DateFormat('yyyy-MMM-dd');
var datetimeformatted = datetimeformatter.format(DateTime.now());

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // FocusNode for controll focus and transfer focus between TextInput Field
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();

  //Assign TextEditingControllers text to variable
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _username => _passwordController.text;

  bool _ispasswordfilled = true;
  bool _isemailfilled = true;
  bool _isusernamefilled = true;
  bool _isregisteron = false;

  @override
  void dispose() {
    super.dispose();
  }

  void login() async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      //connect Class Auth from app/servises/auth.dart using provider create in main.dart

      // send email and password to signInWithEmailAndPassword in auth.dart for login
      await auth.signInWithEmailAndPassword(_email, _password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } on FirebaseAuthException catch (e) {
      QuickAlert.show(
        confirmBtnColor: redColor,
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: firebaseExceptionmessage(e),
        backgroundColor: white,
        titleColor: redColor,
        textColor: redColor,
      );
    }
  }

  void register() async {
    try {
      //connect Class Auth from app/servises/auth.dart using provider create in main.dart
      final auth = Provider.of<AuthBase>(context, listen: false);

      // send email and password to createUserWithEmailandPassword in auth.dart for register
      await auth.createUserWithEmailandPassword(_email, _password);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      ); //pop for go back

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInAnonymously() async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInAnonymously();
      final user = FirebaseAuth.instance.currentUser!.uid;
      print("Sign in $user as Anon");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      ); //pop for go back
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/img/logo.png"),
                  Text("Time Tracker",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: white,
                            fontSize: 10.125.w,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.workSans(
                      textStyle: TextStyle(
                          color: white,
                          fontSize: 9.w,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isregisteron
                      ? textInput(
                          _usernameController,
                          _usernameFocusNode,
                          _isusernamefilled,
                          [
                            "Enter your Name",
                            "Please Enther Username",
                            "Username"
                          ],
                          false)
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  textInput(_emailController, _emailFocusNode, _isemailfilled,
                      ["Enter your Email", "Email Required", "Email"], false),
                  const SizedBox(
                    height: 10,
                  ),
                  textInput(
                    _passwordController,
                    _passwordFocusNode,
                    _ispasswordfilled,
                    ["Enter your Password", "Password Required", "Password"],
                    true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isregisteron
                      ? const SizedBox(
                          height: 12.5,
                        )
                      : googleandanologin(),
                  TextButton(
                      onPressed: () {
                        _isregisteron = !_isregisteron;
                        setState(() {});
                      },
                      child: Text(
                        !_isregisteron
                            ? "No account ? Register"
                            : "Have Account ? Login",
                        style: TextStyle(color: white),
                      ))
                ],
              ),
              Column(
                children: [
                  CustomElebutton(
                    bcolor: white,
                    bcolor2: const Color(0xFFC9FFEC),
                    color: white,
                    fontSize: 9.w,
                    fontcolor: Colors.black,
                    text: 'Lets Go',
                    width: 50.w,
                    height: 8.h,
                    onPressed: () {
                      _email == ""
                          ? _isemailfilled = false
                          : _isemailfilled = true;
                      _password == ""
                          ? _ispasswordfilled = false
                          : _ispasswordfilled = true;
                      _username == ""
                          ? _isusernamefilled = false
                          : _isusernamefilled = true;
                      setState(() {});
                      if (_isemailfilled &&
                          _ispasswordfilled &&
                          !_isregisteron) {
                        login();
                        print("Logged");
                      } else if (_isemailfilled &&
                          _ispasswordfilled &&
                          _isusernamefilled &&
                          _isregisteron) {
                        register();
                        print("Register");
                      } else {
                        print(
                            "$_isemailfilled  $_ispasswordfilled $_isregisteron");
                      }
                    },
                    textStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 6.75.w,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column googleandanologin() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 2,
              width: 20.w,
              color: white,
            ),
            Text("  Or  ",
                style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                    color: white,
                    fontSize: 4.w,
                  ),
                )),
            Container(
              height: 2,
              width: 20.w,
              color: white,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 40.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: FaIcon(FontAwesomeIcons.google, size: 10.w, color: white),
              // ),
              IconButton(
                onPressed: () {
                  signInAnonymously();
                },
                icon: FaIcon(FontAwesomeIcons.userClock,
                    size: 10.w, color: white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox textInput(
    TextEditingController controller,
    FocusNode focusNode,
    bool isfilled,
    List<String> textlist,
    bool obscureText,
  ) {
    return SizedBox(
      width: 80.w,
      height: 55.0,
      child: TextField(
        style: TextStyle(
          color: white,
        ),
        controller: controller,
        focusNode: focusNode,
        onTap: () {
          isfilled = false;
          setState(() {});
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: white,
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: white,
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          labelText: !isfilled ? textlist[1] : textlist[0],
          hintText: textlist[0],
          hintStyle: TextStyle(
            fontSize: 15,
            color: white,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            color: !isfilled ? Colors.red : white,
          ),
        ),
        onChanged: (email) => _updateState(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
