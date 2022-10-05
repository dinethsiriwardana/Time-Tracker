import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/debugLog/debugcolor.dart';
import 'package:timetracker/screen/home_screen/home_screen.dart';
import 'package:timetracker/screen/loading_screens/custom_loading.dart';
import 'package:timetracker/screen/loading_screens/loading_screen.dart';
import 'package:timetracker/service/firebase/database.dart';
import 'package:timetracker/service/model/data_model.dart';

class AutoTarget extends StatefulWidget {
  const AutoTarget({Key? key}) : super(key: key);

  @override
  State<AutoTarget> createState() => _AutoTargetState();
}

class _AutoTargetState extends State<AutoTarget> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<WriteTime>>(
      stream: database.readdataforautotarget(), //! Read Data (database.dart)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          //! Check connection is activer
          if (snapshot.hasData) {
            final mounthData = snapshot.data!.toList();
            // print(mounthData.length);
            if (mounthData.isEmpty) {
              return HomePage(
                autothour: 0,
                autotmin: 0,
              );
            } else {
              int fullworkhour = 0;
              int fullworkmin = 0;
              int looptime = 3;
              // logInfo(mounthData.length.toString());
              if (mounthData.length < 3) {
                looptime = mounthData.length;
              }
              for (var index = 0; index < looptime; index++) {
                // print(mounthData[index].docid);
                fullworkhour = fullworkhour + mounthData[index].chour;
                fullworkmin = fullworkmin + mounthData[index].cmin;
              }

              int targeth = (fullworkhour / 3).round();
              int targetm = (fullworkmin / 3).round();

              return HomePage(
                autothour: targeth,
                autotmin: targetm,
              );
            }
          }
        }

        if (snapshot.hasError) {
          logError(snapshot.error.toString());
          return const LoadingScreen(iserror: false);
        }
        return const LoadingScreen(iserror: false);
      },
    );
  }
}
