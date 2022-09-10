class writeTime {
  writeTime(
      {required this.thour,
      required this.tmin,
      required this.chour,
      required this.cmin,
      required this.docid});
  final int thour;
  final int tmin;
  final int chour;
  final int cmin;
  final String docid;

  factory writeTime.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      throw AssertionError('data must not be null');
    }
    final int thour = data['thour'];
    final int tmin = data["tmin"];
    final int chour = data['chour'];
    final int cmin = data["cmin"];
    final String docid = data["docid"];

    return writeTime(
        thour: thour, tmin: tmin, chour: chour, cmin: cmin, docid: docid);
  }

  Map<String, dynamic> toMap() {
    return {
      "thour": thour,
      "tmin": tmin,
      "chour": chour,
      "cmin": cmin,
      "docid": docid,
    };
  }
}
