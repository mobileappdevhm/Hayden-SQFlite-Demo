class Note {
  String _classname;
  String _note;

  Note(this._classname, this._note);

  Note.map(dynamic obj) {
    this._classname = obj['classname'];
    this._note = obj['note'];
  }

  String get classname => _classname;
  String get note => _note;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["classname"] = _classname;
    map["note"] = _note;
    return map;
  }
}