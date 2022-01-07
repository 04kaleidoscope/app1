import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app1/services/firestore.dart';
import 'package:app1/shared/loading.dart';
import 'package:app1/shared/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app1/quiz/quiz_state.dart';
import 'package:app1/services/models.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return const LoadingScreen();
          } else {
            var quiz = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: AnimatedProgressBar(value: state.progress, height: 12),
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.timesCircle),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz);
                  } else if (idx == quiz.questions.length + 1) {
                    return FinalPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx -1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline4),
          const Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton.icon(
                    onPressed: state.nextPage,
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 20,
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      backgroundColor: Color(0xFFFFA000),
                    ),
                    label: const Text(
                      'start',
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FinalPage extends StatelessWidget {
  final Quiz quiz;
  const FinalPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'You\'ve completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Bravo!',
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange, //Firebase orange
                  )),
              WavyAnimatedText('You\'re amazing!',
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange, //Firebase orange
                  )),
            ],
            isRepeatingAnimation: true,
          ),
          const Spacer(),
          const Icon(
            FontAwesomeIcons.thumbsUp,
            color: Colors.deepOrange,
            size: 100,
          ),
          const Spacer(),
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 30, right: 30),
              backgroundColor: Color(0xFFFFA000),
            ),
            icon: const Icon(
              Icons.save,
              color: Colors.white,
              size: 20,
            ),
            label: const Text(' mark completed'),
            onPressed: () {
              FirestoreService().updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                (route) => false,
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                width: 700,
                height: 80,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.black38,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.circle,
                            size: 25),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  _bottomSheet(BuildContext context, Option opt, QuizState state) {
    bool correct = opt.correct;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Correct!' : 'Wrong answer'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: correct ? Colors.green : Colors.red),
                child: Text(
                  correct ? 'Next one!' : 'Try again',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}