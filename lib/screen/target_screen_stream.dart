// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:timetracker/custom/customcolor.dart';
import 'package:timetracker/custom/show_exception_alert_dialog.dart';
import 'package:timetracker/screen/home_screen.dart';
import 'package:timetracker/screen/loading_screen.dart';
import 'package:timetracker/screen/target_screen.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

class TargetScreenStream extends StatefulWidget {
  const TargetScreenStream({Key? key}) : super(key: key);

  @override
  State<TargetScreenStream> createState() => _TargetScreenStreamState();
}

class _TargetScreenStreamState extends State<TargetScreenStream> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-1, -1), // near the top right
          radius: 2,
          colors: [
            const Color(0xFF47985D),
            greenColor,
          ],
        ),
        // color: white,
      ),
      child: SafeArea(
        bottom: false,
        left: true,
        // top: true,
        right: true,
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          body: StreamBuilder<List<WriteTime>>(
            stream: database.readDataStream(), //! Read Data (database.dart)
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                //! Check connection is activer
                if (snapshot.hasData) {
                  final timedata = snapshot.data!.toList();

                  if (timedata.isEmpty) {
                    print("No Any Record For Today \nCreating New target");
                    return const HomePage();
                  } else {
                    return TargetScreen(
                      readdata: timedata[0],
                    );
                  }
                  // print(timedata[0].docid);
                }
              }

              if (snapshot.hasError) {
                print("Type ${snapshot.error}");
                // FirebaseException errexception =
                //     snapshot.error as FirebaseException;
                // String? errmsg = firebaseExceptionmessage(errexception);
                return LoadingScreen(
                  iserror: true,
                );
              }

              return const LoadingScreen(
                iserror: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
