import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/services/dummy_data/q_a/random.dart';
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

  String getQuestions(int index) => modelQuestions[index]['question'];

  getOptions(int index) => modelQuestions[index]['options'];

  String getAnswer(int index) => modelQuestions[index]['answer'];

  getAnsKeys(int mainIndex, index) =>
      getOptions(mainIndex).keys.toList()[index];

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
