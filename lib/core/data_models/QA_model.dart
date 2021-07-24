import 'dart:convert';

class QAModel {
  QAModel({required this.questionData});

  final List<QuestionData> questionData;

  factory QAModel.fromMap(List<Map<String, dynamic>> questions) => QAModel(
      questionData: List<QuestionData>.from(
          questions.map((e) => QuestionData.fromMap(e))));
  // List<QuestionData> questionData;

  // QAModel({required this.questionData}); // List of map is passed here

  // var list = [];

  // factory QAModel.fromMap(List questions) {
  //   for (var i = 0; i < questions.length; i++) {
  //   QAModel(questionData: QuestionData(question: question, options: options, answer: answer))
  // }
  //   return
  // }

  // factory QAModel.fromMap(Map<String, dynamic> data) =>
  //     QAModel(questionData: List<QuestionData>.from(data.map((x) => QuestionData.fromMap(x))));
}

class QuestionData {
  QuestionData({
    required this.question,
    required this.options,
    required this.answer,
  });

  String question;
  Options options;
  String answer;

  factory QuestionData.fromJson(String str) =>
      QuestionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuestionData.fromMap(Map<String, dynamic> map) => QuestionData(
        question: map["question"],
        options: Options.fromMap(map["options"]),
        answer: map["answer"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "options": options.toMap(),
        "answer": answer,
      };
}

class Options {
  Options({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  String a;
  String b;
  String c;
  String d;

  // factory Options.fromRawJson(String str) => Options.fromMap(json.decode(str));

  // String toRawJson() => json.encode(toMap());

  factory Options.fromMap(Map<String, dynamic> map) => Options(
        a: map["A"],
        b: map["B"],
        c: map["C"],
        d: map["D"],
      );

  Map<String, dynamic> toMap() => {
        "A": a,
        "B": b,
        "C": c,
        "D": d,
      };
}
