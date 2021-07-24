import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/services/dummy_data/q_a/random.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class QuestionViewModel extends BaseViewModel {
  List<dynamic> stateList = List<dynamic>.filled(
    questions.length,
    '',
    growable: false,
  ); // on initializing list the list looks like this ['', '', ''] // This holds the state for the radio button i.e selected answers

  SwiperController swiperController = SwiperController();

  var modelQuestions = questions;
  int controllerIndexValue = 0;

  /// Extract questions using the index of [Swiper] i.e mainIndex
  String getQuestions(int index) => modelQuestions[index]['question'];

  /// Extract options using the index of [Swiper] i.e mainIndex
  getOptions(int index) => modelQuestions[index]['options'];

  /// Extract correct answer to the question using the index of [Swiper] i.e mainIndex
  String getAnswer(int index) => modelQuestions[index]['answer'];

  /// Extract keys of each option [A, B, C...] using the index of [Swiper]
  /// i.e mainIndex and also index of [ListView.builder]
  getAnsKeys(int mainIndex, index) =>
      getOptions(mainIndex).keys.toList()[index];

  /// Extract Value of each option using the index of [Swiper]
  /// i.e mainIndex and also index of [ListView.builder]
  getAnsValues(int mainIndex, index) =>
      getOptions(mainIndex).values.toList()[index];

  bool isLastQuestion() => modelQuestions.length == controllerIndexValue + 1;

  bool isFirstQuestion() => controllerIndexValue == 0;

  score() {
    int score = 0;
    for (var i = 0; i < stateList.length; i++) {
      if (getAnswer(i) == stateList[i]) {
        score++;
      }
    }
    print(score);
  }

  // updateCIV(int value) {
  //   controllerIndexValue = value;
  //   notifyListeners();
  // }
}
