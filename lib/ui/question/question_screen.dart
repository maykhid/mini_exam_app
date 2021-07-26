import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/core/data_models/QA_model.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/ui/question/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends StatefulWidget {
  QuestionScreen({required this.collection, required this.doc});
  final String collection;
  final String doc;

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  /* 
  Note to self: The stateList created is to store the value of radio button (for each specific question) and hold
  the answer picked by the user
  */

  late List<String> stateList;
  late List<String> answerList;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionViewModel>(builder: (context, model, child) {
      return BaseView(
        body: FutureBuilder<QAModel>(
          future: model.pullQA(FirestoreParams(
              collection: widget.collection, document: widget.doc)),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              stateList = List<String>.filled(
                //
                snapshot.data!.questionData.length,
                '',
                growable: false,
              );

              answerList = model.generateAnswerAsList(snapshot);

              return Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSwiperContainer(model, snapshot),
                  //
                  buildButtonContainer(model, snapshot),
                ],
              );
            }

            return Container();
          },
        ),
      );
    });
  }

  //
  Container buildSwiperContainer(
      QuestionViewModel model, AsyncSnapshot<QAModel> snapshot) {
    var snapshotData = snapshot.data!;

    return Container(
      height: 80.h,
      width: 100.w,
      child: Swiper(
        loop: false,
        controller: model.swiperController,
        itemBuilder: (BuildContext context, int mainIndex) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // question
              Center(
                child: Text(
                    '(${mainIndex + 1}) ${snapshotData.questionData[mainIndex].question}'),
              ),
              // answer

              buildAnswerContainer(model, mainIndex, snapshot),
            ],
          );
        },
        itemCount: model.modelQuestions.length,
        pagination: new SwiperPagination(),
      ),
    );
  }

  //
  buildAnswerContainer(
      QuestionViewModel model, int mainIndex, AsyncSnapshot<QAModel> snapshot) {
    var snapshotData = snapshot.data!;

    return StatefulBuilder(
        // stream: null,
        builder: (context, state) {
      return Container(
        height: 50.h,
        child: ListView.builder(
          itemBuilder: (context, index) {
            //

            // var _ = model.getAnsKeys(mainIndex,
            //     index); // The a key that reps a value (option) i.e A, B...

            // var _v = model.getAnsValues(mainIndex,
            //     index); // The map value that holds an option of a question

            var options = snapshotData.questionData[mainIndex].options;

            var _ = options.toMap().keys.toList()[index];

            var _v = options.toMap().values.toList()[index];

            model.controllerIndexValue = mainIndex;

            return RadioListTile<String>(
              value: _,
              groupValue: stateList[
                  mainIndex], // store the user selected answer, also inadvertently, store selected 'state' of the RadioListTile
              onChanged: (newVal) {
                state(() {
                  stateList[mainIndex] =
                      newVal!; // assign new value to the model.stateList[mainIndex]

                  print(stateList);
                });
              },
              title: Text('$_ : $_v'),
            );
          },

          itemCount: snapshotData.questionData[mainIndex].options
              .toMap()
              .keys
              .toList()
              .length, // use length of options as length of itemCount
        ),
      );
    });
  }

  //
  Container buildButtonContainer(
      QuestionViewModel model, AsyncSnapshot<QAModel> snapshot) {
    return Container(
      width: 100.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              TextButton(
                onPressed: () {
                  if (model.isFirstQuestion()) {
                    // setState(() {});
                    return;
                  }
                  model.swiperController.previous();
                },
                child: Text(
                  'Prev',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.brown)),
              ),

              TextButton(
                onPressed: () {
                  if (model
                      .isLastQuestion(snapshot.data!.questionData.length)) {
                    // setState(() {});
                    return;
                  }
                  model.swiperController.next();
                },
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.brown),
                ),
              ),
            ],
          ),

          /// Extract options using the index of [Swiper] i.e mainIndex
          TextButton(
            onPressed: () => model.score(answerList, stateList),
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(30.w)),
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors.brown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
