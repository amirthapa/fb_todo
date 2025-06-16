class NoteModel {
  int? id;
  String? title;
  String? content;
  String? timestamp;
  bool? share;

  NoteModel({this.id, this.title, this.content, this.timestamp, this.share});

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
    if (json["id"] is int) {
      id = json["id"];
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'shared': share,
    };
  }
}
