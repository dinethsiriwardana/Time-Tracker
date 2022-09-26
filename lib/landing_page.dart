import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/screen/loading_screen.dart';
import 'package:timetracker/screen/login_screen.dart';
import 'package:timetracker/screen/target_screen/target_screen_stream.dart';
import 'package:timetracker/service/firebase/auth.dart';
import 'package:timetracker/service/firebase/database.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,
        listen: false); //Get Data from 'app/servises/auth.dart' using provider

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
          // print(user.uid);
          return Provider<Database>(
            create: (_) => FirestoreDatabase(user: user.uid),
            child: TargetScreenStream(),
          );
        }
        return const LoadingScreen(
          iserror: false,
        );
      },
    );
  }
}
