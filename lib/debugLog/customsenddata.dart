// Future<void> writeData(BuildContext context) async {
//   final database = Provider.of<Database>(context, listen: false);
//   int datetimeformatted = 20220908;
//   //! Use provider to connect with Database Class in service/database.dart
//   try {
//     for (var i = 20221008; i < 20221018; i++) {
//       var rng = Random();

//       await database.writeData(
//         i.toString(),
//         WriteTime(
//             docid: i.toString(),
//             thour: rng.nextInt(23),
//             tmin: rng.nextInt(60),
//             chour: rng.nextInt(20),
//             cmin: rng.nextInt(55),
//             lastupdate: '08:27:14 AM'),
//       );
//       print("Done $i");
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }