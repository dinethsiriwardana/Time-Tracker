import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timetracker/service/api_path.dart';

import 'package:timetracker/service/model/data_model.dart';
import 'package:timetracker/service/model/datetimemodel.dart';

abstract class Database {
  Future<void> writeData(String datatime, WriteTime wDataModel);
  Stream<List<WriteTime>> readDataStream();
  Stream<List<WriteTime>> readAllDataStream(reqmonth);
  Future<void> deleteaccount();
}

// /data/student_details/2010/
class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.user}) : assert(user != null);
  final String user;

  @override
  Future<void> writeData(String datatime, WriteTime wDataModel) =>
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

  @override
  Future<void> deleteaccount() async {
    try {
      FirebaseFirestore.instance
          .collection('users/$user/2022')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      print("Delet from the database");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<List<WriteTime>> readDataStream() {
    final monthData = dateTimeNow('yyyyMMdd');
    // print("Dota is -  $monthData (Read From ReadDataStream)");
    print("Read Data from $user in date $monthData");
    final path = APIPath.rdatapath(user);
    final reference = FirebaseFirestore.instance
        .collection(path)
        .where('docid', isEqualTo: monthData);
    // .doc(monthData) //CollectionReference<Map<String, dynamic>> / CollectionReference<Map<String, dynamic>>

    final snapshots = reference
        .snapshots(); //Stream<QuerySnapshot<Map<String, dynamic>>> snapshots / Stream<DocumentSnapshot<Map<String, dynamic>>>
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => WriteTime.fromMap(snapshot.data()))
        .toList());
  }

  @override
  Stream<List<WriteTime>> readAllDataStream(reqmonth) {
    String searchrangeS = reqmonth <= 9 ? "20220$reqmonth" : "2022$reqmonth";
    String searchrangeE =
        reqmonth + 1 <= 9 ? "20220${reqmonth + 1}" : "2022${reqmonth + 1}";

    print("Read Data from $user in range $searchrangeE");
    final path = APIPath.rdatapath(user);
    final reference = FirebaseFirestore.instance
        .collection(path)
        // .orderBy('tmin')
        .where('docid', isGreaterThanOrEqualTo: searchrangeS);
    //
    ;

    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => WriteTime.fromMap(snapshot.data()))
        .toList());
  }
}
