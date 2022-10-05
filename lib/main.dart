import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timetracker/custom/readonetime.dart';
import 'package:timetracker/others/firebase_options.dart';
import 'package:timetracker/screen/home_screen/home_screen.dart';
import 'package:timetracker/screen/show_log/log_screen.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/landing_page.dart';
import 'package:timetracker/service/firebase/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MultiProvider(
          providers: [
            Provider<AuthBase>(create: (_) => Auth()),
          ],
          //Add Auth class as a provider to import auth to the class & send provider to LandingPage

          child: MaterialApp(
            title: 'Time Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              // '/home': (context) => const HomePage(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/LogScreen': (context) => LogScreen(),
            },
            home:
                //
                // TargetScreenStream(),
                // ReadOneTime(),
                const LandingPage(),
          ));
    });
  }
}
