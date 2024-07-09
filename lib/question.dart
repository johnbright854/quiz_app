import 'main.dart';

class Question {

  late String questionText;
  late bool questionAnswer;

  Question({required q, required a}){
    this.questionText = q;
    this.questionAnswer = a;
  }
}