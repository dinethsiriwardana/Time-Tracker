import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/custom/readonetime.dart';
import 'package:timetracker/screen/loading_screens/loading_screen.dart';
import 'package:timetracker/screen/login_screen.dart';
import 'package:timetracker/screen/show_log/log_screen.dart';
import 'package:timetracker/screen/show_log/log_stream.dart';
import 'package:timetracker/screen/target_screen/target_screen_stream.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/v_checker.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appvGET = '';
    String appvrREAD = '';
    Future<bool> getAppV() async {
      await FirebaseFirestore.instance
          .collection('setting')
          .doc('appversion')
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data() as Map;

          appvGET = data['appv'].toString();
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          appvrREAD = packageInfo.version.toString();
        }
      });

      if (appvGET == appvrREAD) {
        return true;
      } else {
        return false;
      }
    }

    final auth = Provider.of<AuthBase>(context,
        listen: false); //Get Data from 'app/servises/auth.dart' using provider

    return FutureBuilder<bool>(
        future: getAppV(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);
            if (snapshot.data != false) {
              return StreamBuilder<User?>(
                  //  Create stream builder
                  stream: auth
                      .authStateChanges(), // check authStateChanges in auth.dart for check the user is logged
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final User? user = snapshot.data;
                      if (user == null) {
                        //if no user logged
                        return const LoginPage();
                      }

                      return Provider<Database>(
                        create: (_) => FirestoreDatabase(user: user.uid),
                        child: const MaterialApp(
                          home: TargetScreenStream(),
                          debugShowCheckedModeBanner: false,
                        ),
                        // child: ReadOneTime()
                        // child: LogScreen(),
                      );
                    }
                    return const LoadingScreen(
                      iserror: false,
                    );
                  });
            } else {
              return const versionCheck();
            }
          } else {
            return const LoadingScreen(
              iserror: false,
            );
          }
        });
  }
}
