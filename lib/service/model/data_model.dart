// ignore_for_file: unnecessary_null_comparison

class WriteTime {
  WriteTime(
      {required this.thour,
      required this.tmin,
      required this.chour,
      required this.cmin,
      required this.docid,
      required this.lastupdate});
  final int thour;
  final int tmin;
  final int chour;
  final int cmin;
  final String docid;
  final String lastupdate;

  factory WriteTime.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      throw AssertionError('data must not be null');
    }
    final int thour = data['thour'];
    final int tmin = data["tmin"];
    final int chour = data['chour'];
    final int cmin = data["cmin"];
    final String docid = data["docid"];
    String lastupdate = data["lastupdate"];

    return WriteTime(
        thour: thour,
        tmin: tmin,
        chour: chour,
        cmin: cmin,
        docid: docid,
        lastupdate: lastupdate);
  }

  Map<String, dynamic> toMap() {
    return {
      "thour": thour,
      "tmin": tmin,
      "chour": chour,
      "cmin": cmin,
      "docid": docid,
      "lastupdate": lastupdate,
    };
  }
}
