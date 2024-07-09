import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkCorrectAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.GetCorrectAnswer();
    setState(() {
        if(quizBrain.isFinished() == true){
          Alert(
            context: context,
            type: AlertType.error,
            title: "The End",
            desc: "The quiz is completed.",
            buttons: [
              DialogButton(
                child: Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
          quizBrain.reset();
          scoreKeeper = [];
    }else{
          if(userPickedAnswer == correctAnswer){
            scoreKeeper.add(const Icon(Icons.check,
                color: Colors.green
            ));
          }else{
            scoreKeeper.add(const Icon(Icons.close,
                color: Colors.red
            ));
          }
          quizBrain.nextQuestion();
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:<Widget> [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.GetQuestionText(),
                    textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FloatingActionButton(
            foregroundColor: Colors.lightGreenAccent,
              backgroundColor: Colors.green,
              child: Text("true", style: TextStyle(color: Colors.white, fontSize: 25.0),),
              onPressed: (){
                checkCorrectAnswer(true);
              }),
        ),
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FloatingActionButton(
              foregroundColor: Colors.redAccent,
              backgroundColor: Colors.red,
              child: Text("false", style: TextStyle(color: Colors.white, fontSize: 25.0),),
              onPressed: (){
                  checkCorrectAnswer(false);
              }),
        ),
        ),
        SafeArea(
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/


