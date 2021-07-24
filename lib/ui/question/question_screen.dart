import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/ui/question/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  /* 
  Note to self: The _stateList created is to store the value of radio button (for each specific question) and hold
  the answer picked by the user
  */

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionViewModel>(builder: (context, model, child) {
      return BaseView(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSwiperContainer(model),
            //
            buildButtonContainer(model)
          ],
        ),
      );
    });
  }

  //
  Container buildSwiperContainer(QuestionViewModel model) {
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
                child:
                    Text('(${mainIndex + 1}) ${model.getQuestions(mainIndex)}'),
              ),
              // answer

              buildAnswerContainer(model, mainIndex),
            ],
          );
        },
        itemCount: model.modelQuestions.length,
        pagination: new SwiperPagination(),
      ),
    );
  }

  //
  Container buildButtonContainer(QuestionViewModel model) {
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
                    setState(() {});
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
              //
              TextButton(
                onPressed: () {
                  if (model.isLastQuestion()) {
                    setState(() {});
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
            onPressed: () => model.score(),
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

  //
  Container buildAnswerContainer(QuestionViewModel model, int mainIndex) {
    return Container(
      height: 50.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          //

          var _ = model.getAnsKeys(mainIndex,
              index); // The a key that reps a value (option) i.e A, B...

          var _v = model.getAnsValues(mainIndex,
              index); // The map value that holds an option of a question

          model.controllerIndexValue = mainIndex;

          //
          return RadioListTile<String>(
            value: _,
            groupValue: model.stateList[mainIndex],
            onChanged: (newVal) => setState(() {
              // value = newVal;
              model.stateList[mainIndex] =
                  newVal; // assign new value to the model.stateList[mainIndex]
              print(model.stateList);
            }),
            title: Text('$_ : $_v'),
          );
        },
        itemCount: model.getOptions(mainIndex).length,
      ),
    );
  }
}
