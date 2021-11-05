import 'package:exam_cheat_detector/app/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/core/data_models/QA_model.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/ui/widgets/count_down_timer.dart';

import 'question_view_model.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = "/questionScreen";

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  /* 
  Note to self: The stateList created is to store the value of radio button (for each specific question) and hold
  the answer picked by the user
  */

  late List<String> stateList; // This list stores the user selected answers
  late List<String>
      answerList; // This list stores all answer values from firestore

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as FirestoreParams; // args to get argument passed from the previous screen on navigating to this screen

    return ChangeNotifierProvider(
        create: (_) => QuestionViewModel(firestoreDBUseCase: locator()),
        builder: (context, snapshot) {
          return Builder(builder: (context) {
            var model = Provider.of<QuestionViewModel>(context);

            return BaseView(
              body: FutureBuilder<QAModel>(
                future: model.pullQA(FirestoreParams(
                    collection: args.collection, document: args.document)),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    //
                    stateList = List<String>.filled(
                      //
                      snapshot.data!.questionData.length,
                      '',
                      growable: false,
                    ); // assign to stateList, a list of known length (length of questionData) with '' stored at each index

                    answerList = model.generateAnswerAsList(
                        snapshot); // assign to answerList, a list of all answer values stored in firestore

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // camera and timer
                          _buildCameraAndTimer(model),

                          SizedBox(height: 5.h),
                          // swiper / question and answer
                          _buildSwiperContainer(model, snapshot),

                          // buttons
                          _buildButtonContainer(model, snapshot),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            );
          });
        });
  }

  // The Swiper that displays the test
  _buildSwiperContainer(
      QuestionViewModel model, AsyncSnapshot<QAModel> snapshot) {
    List snapshotData = snapshot.data!.questionData;

    return Container(
      height: 50.h,
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
                child: Text('${snapshotData[mainIndex].question}'),
              ),
              // answer

              _buildOptionsContainer(model, mainIndex, snapshot),
            ],
          );
        },
        itemCount: snapshotData.length,
        // pagination: new SwiperPagination(),
        pagination: SwiperPagination.fraction,
      ),
    );
  }

  // The options Container
  _buildOptionsContainer(
      QuestionViewModel model, int mainIndex, AsyncSnapshot<QAModel> snapshot) {
    var snapshotData = snapshot.data!.questionData;

    return StatefulBuilder(
        // stream: null,
        builder: (context, state) {
      return Container(
        height: 30.h,
        child: ListView.builder(
          itemBuilder: (context, index) {
            var options = snapshotData[mainIndex]
                .options
                .toMap(); // options from firestore db

            var _k = options.keys.toList()[
                index]; // convert options keys to list and assign the value at index to _k

            var _v = options.values.toList()[
                index]; // convert options values to list and assign the value at index to _v

            model.controllerIndexValue = mainIndex;

            return RadioListTile<String>(
              value: _k,
              groupValue: stateList[mainIndex],
              onChanged: (newVal) {
                state(() {
                  stateList[mainIndex] =
                      newVal!; // assign new value to the model.stateList[mainIndex]

                  print(stateList);
                });
              },
              title: Text('$_k : $_v'),
            );
          },

          itemCount: snapshotData[mainIndex]
              .options
              .toMap()
              .keys
              .toList()
              .length, // use length of options as length of itemCount
        ),
      );
    }); // StateBuilder in this case prevents the whole screen from being rebuilt onSetState when an answer is selected
  }

  //
  _buildButtonContainer(
      QuestionViewModel model, AsyncSnapshot<QAModel> snapshot) {
    var snapshotData = snapshot.data!.questionData;

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
                      MaterialStateProperty.all<Color>(AppColors.brown),
                ),
              ),

              TextButton(
                onPressed: () {
                  if (model.isLastQuestion(snapshotData.length)) {
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
            // onPressed: () => model.score(answerList, stateList),
            onPressed: () => _showMyDialog(model),
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

  _buildTimer(QuestionViewModel model) {
    return Container(
      width: 10.h,
      height: 5.h,
      padding: EdgeInsets.only(top: 3.0, right: 4.0),
      child: CountDownTimer(
        secondsRemaining: 720,
        whenTimeExpires: () {
          // setState(() {
          //   hasTimerStopped = true;
          // });
          _showAnswerDialog(model.score(answerList, stateList), true);
        },
        countDownTimerStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          height: 1.2,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.blue),
    );
  }

  _buildCameraDisplay() {
    return Container(
      width: 20.w,
      height: 15.h,
      color: Colors.black,
    );
  }

  _buildCameraAndTimer(QuestionViewModel model) {
    return Container(
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // timer
          _buildTimer(model),

          // camera display
          _buildCameraDisplay(),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(QuestionViewModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Submit?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to submit?'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No, Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 2.w,
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.brown)),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _showAnswerDialog(model.score(answerList, stateList), false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAnswerDialog(int score, bool elapsed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Your Score!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                elapsed ? Text('Your time has elapsed!⏰') : Text(' '),
                Center(
                    child: Text('$score', style: TextStyle(fontSize: 10.sp))),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // pops back to homescreen
              },
            ),
          ],
        );
      },
    );
  }
}
