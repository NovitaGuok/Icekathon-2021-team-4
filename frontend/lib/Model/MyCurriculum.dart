class MyCurriculum {
  String? code;
  String? message;
  List<Data>? data;
  Meta? meta;

  MyCurriculum({this.code, this.message, this.data, this.meta});

  MyCurriculum.fromJson(Map<String, dynamic> json) {
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
  String? highlightPict;
  String? curriculumId;
  String? curriculumTitle;
  bool? quizEnabled;

  Data(
      {this.id,
        this.title,
        this.description,
        this.highlightPict,
        this.curriculumId,
        this.curriculumTitle,
        this.quizEnabled});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    highlightPict = json['highlight_pict'];
    curriculumId = json['curriculum_id'];
    curriculumTitle = json['curriculum_title'];
    quizEnabled = json['quiz_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['highlight_pict'] = this.highlightPict;
    data['curriculum_id'] = this.curriculumId;
    data['curriculum_title'] = this.curriculumTitle;
    data['quiz_enabled'] = this.quizEnabled;
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