import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/data_models/QA_model.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';
import 'package:exam_cheat_detector/core/services/dummy_data/q_a/random.dart';
import 'package:exam_cheat_detector/core/use_cases/firebasedb_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class QuestionViewModel extends BaseViewModel {
  FirestoreDBUseCase firestoreDBUseCase;

  QuestionViewModel({required this.firestoreDBUseCase});

  // List<dynamic> stateList = List<dynamic>.filled(
  //   questions.length,
  //   '',
  //   growable: false,
  // ); // on initializing list the list looks like this ['', '', ''] // This holds the state for the radio button i.e selected answers

  SwiperController swiperController = SwiperController();

  var modelQuestions = questions;
  int controllerIndexValue = 0;

  /// Extract questions using the index of [Swiper] i.e mainIndex
  // String getQuestions(int index) => modelQuestions[index]['question'];

  /// Extract options using the index of [Swiper] i.e mainIndex
  // getOptions(int index) => modelQuestions[index]['options'];

  /// Extract correct answer to the question using the index of [Swiper] i.e mainIndex
  // String getAnswer(int index) => modelQuestions[index]['answer'];

  /// Extract keys of each option [A, B, C...] using the index of [Swiper]
  /// i.e mainIndex and also index of [ListView.builder]
  // getAnsKeys(int mainIndex, index) =>
  //     getOptions(mainIndex).keys.toList()[index];

  /// Extract Value of each option using the index of [Swiper]
  /// i.e mainIndex and also index of [ListView.builder]
  // getAnsValues(int mainIndex, index) =>
  //     getOptions(mainIndex).values.toList()[index];

  bool isLastQuestion(int questionLength) =>
      questionLength == controllerIndexValue + 1;

  bool isFirstQuestion() => controllerIndexValue == 0;

  /// Get db questions from firestore
  Future<QAModel> pullQA(FirestoreParams params) async {
    try {
      var data = await firestoreDBUseCase.retreiveData(params);

      print(data.data());
      return QAModel.fromMap(data.data()!['default']);
    } on ServerError catch (e) {
      throw ServerError(e.message);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
    // return
  }

  List<String> generateAnswerAsList(AsyncSnapshot<QAModel> snapshot) {
    var questionData = snapshot.data!.questionData;

    List<String> answer = [];

    for (int i = 0; i < questionData.length; i++) {
      answer.add(questionData[i].answer);
      // print(answer[i]);
    }
    return answer;
  }

  score(List<String> answerList, List<String> stateList) {
    int score = 0;
    for (int i = 0; i < answerList.length; i++) {
      if (answerList[i] == stateList[i]) {
        score++;
      }
    }
    print(score);
  }
}
