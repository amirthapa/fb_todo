class NoteModel {
  String? title;
  String? content;
  String? timestamp;
  bool? share;

  NoteModel({this.title, this.content, this.timestamp, this.share});

  NoteModel.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
    if (json["timestamp"] is String) {
      timestamp = json["timestamp"];
    }
    if (json["share"] is bool) {
      share = json["share"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["content"] = content;
    data["timestamp"] = timestamp;
    data["share"] = share;
    return data;
  }
}
