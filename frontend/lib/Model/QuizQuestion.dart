class SubmitBody {
  List<Answers> answers = [];

  SubmitBody({required this.answers});

  SubmitBody.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? id;
  String? chosenOption;

  Answers({ required this.id, required this.chosenOption});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chosenOption = json['chosen_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chosen_option'] = this.chosenOption;
    return data;
  }
}

class QuizQuestion {
  String? code;
  String? message;
  QuestionData? data;

  QuizQuestion({this.code, this.message, this.data});

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new QuestionData.fromJson(json['data']) : null;
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

class QuestionData {
  int? totalQuestion;
  List<Questions>? questions;

  QuestionData({this.totalQuestion, this.questions});

  QuestionData.fromJson(Map<String, dynamic> json) {
    totalQuestion = json['total_question'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_question'] = this.totalQuestion;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? quizId;
  String? question;
  String? choiceA;
  String? choiceB;
  String? choiceC;
  String? choiceD;
  String? choiceE;

  Questions(
      {this.quizId,
        this.question,
        this.choiceA,
        this.choiceB,
        this.choiceC,
        this.choiceD,
        this.choiceE});

  Questions.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    question = json['question'];
    choiceA = json['choice_a'];
    choiceB = json['choice_b'];
    choiceC = json['choice_c'];
    choiceD = json['choice_d'];
    choiceE = json['choice_e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz_id'] = this.quizId;
    data['question'] = this.question;
    data['choice_a'] = this.choiceA;
    data['choice_b'] = this.choiceB;
    data['choice_c'] = this.choiceC;
    data['choice_d'] = this.choiceD;
    data['choice_e'] = this.choiceE;
    return data;
  }
}