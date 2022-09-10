import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
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

    return Scaffold(
      body: StreamBuilder<List<writeTime>>(
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
            print("Has Some error");
            return const Center(
              child: Text("Has Some error"),
            );
          }

          return const LoadingScreen();
        },
      ),
    );
  }
}
