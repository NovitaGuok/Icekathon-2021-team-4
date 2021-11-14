class QuizStatus {
  String? code;
  String? message;
  StatusData? data;

  QuizStatus({this.code, this.message, this.data});

  QuizStatus.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new StatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StatusData {
  String? courseId;
  String? userId;
  int? score;

  StatusData({this.courseId, this.userId, this.score});

  StatusData.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    userId = json['user_id'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['score'] = this.score;
    return data;
  }
}