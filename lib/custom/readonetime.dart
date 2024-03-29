import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetracker/debugLog/debugcolor.dart';

class ReadOneTime extends StatefulWidget {
  const ReadOneTime({Key? key}) : super(key: key);

  @override
  State<ReadOneTime> createState() => _ReadOneTimeState();
}

class _ReadOneTimeState extends State<ReadOneTime> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // FirebaseAuth.instance.userChanges().
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('5etTwzVKf5VKiH6uqD1RzmMJnk83').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // if (data["bom"]?["202209"] == "") {
          //   print('null');
          // } else {
          //   print(data["bom"]["202209"]);

          // }
          print(data);
        }

        return Text("loading");
      },
    );
  }
}

readdataonetime() {
  try {
    FirebaseFirestore.instance
        .collection('users')
        .doc('5etTwzVKf5VKiH6uqD1RzmMJnk83')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        // print(documentSnapshot.data();
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print(data['details']['bom'][0]);
      }
    });
  } catch (e) {
    logError(e.toString());
  }
}
