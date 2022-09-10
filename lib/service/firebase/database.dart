import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetracker/service/api_path.dart';

import 'package:timetracker/service/model/data_model.dart';
import 'package:timetracker/service/model/datetimemodel.dart';

abstract class Database {
  Future<void> writeData(String datatime, writeTime wDataModel);
  Stream<List<writeTime>> readDataStream();
}

// /data/student_details/2010/
class FirestoreDatabase implements Database {
  final user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> writeData(String datatime, writeTime wDataModel) =>
      _writedataCommon(
        path: APIPath.wdatapath(datatime,
            user), // ! path create using firebase/service/api_path.dart
        data: wDataModel
            .toMap(), // ! Model create using firebase/model/w.data_model.dart
      );

  Future<void> _writedataCommon({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Stream<List<writeTime>> readDataStream() {
    final monthData = dateTimeNow('yyyyMMdd');
    print("Dota is -  $monthData (Read From ReadDataStream)");
    final path = APIPath.rdatapath(user);
    final reference = FirebaseFirestore.instance
        .collection(path)
        .where('docid', isEqualTo: monthData);
    // .doc(monthData) //CollectionReference<Map<String, dynamic>> / CollectionReference<Map<String, dynamic>>
    ;
    final snapshots = reference
        .snapshots(); //Stream<QuerySnapshot<Map<String, dynamic>>> snapshots / Stream<DocumentSnapshot<Map<String, dynamic>>>
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => writeTime.fromMap(snapshot.data()))
        .toList());
  }
}
