class Lesson {
  String? code;
  String? message;
  List<Data>? data;
  Meta? meta;

  Lesson({this.code, this.message, this.data, this.meta});

  Lesson.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? description;
  String? contentType;
  String? contentUrl;
  String? highlightPict;
  String? level;
  String? courseId;

  Data(
      {this.id,
        this.title,
        this.description,
        this.contentType,
        this.contentUrl,
        this.highlightPict,
        this.level,
        this.courseId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    contentType = json['content_type'];
    contentUrl = json['content_url'];
    highlightPict = json['highlight_pict'];
    level = json['level'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['content_type'] = this.contentType;
    data['content_url'] = this.contentUrl;
    data['highlight_pict'] = this.highlightPict;
    data['level'] = this.level;
    data['course_id'] = this.courseId;
    return data;
  }
}

class Meta {
  String? next;
  String? current;
  String? previous;
  int? totalItem;
  int? totalPage;

  Meta(
      {this.next, this.current, this.previous, this.totalItem, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    current = json['current'];
    previous = json['previous'];
    totalItem = json['total_item'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['current'] = this.current;
    data['previous'] = this.previous;
    data['total_item'] = this.totalItem;
    data['total_page'] = this.totalPage;
    return data;
  }
}