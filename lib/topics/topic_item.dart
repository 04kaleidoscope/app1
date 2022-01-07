import 'package:app1/shared/progress_bar.dart';
import 'package:app1/topics/drawer.dart';
import 'package:app1/topics/topics.dart';
import 'package:flutter/material.dart';
import 'package:app1/services/models.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TopicScreen(topic: topic),
            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                    child: Image.asset(
                  'assets/products/${topic.img}',
                  fit: BoxFit.contain,
                )),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 2,
                      color: Colors.deepOrangeAccent
                    ),
                    //overflow: TextOverflow.fade,
                    softWrap: false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(child: TopicProgress(topic: topic))
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;
  const TopicScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SizedBox(
          width: 700,
          child: ListView(
            children: [
              Hero(
                tag: topic.img,
                child: Image.asset('assets/products/${topic.img}',
                    width: MediaQuery.of(context).size.width),
              ),
              Text(
                topic.title,
                style: const TextStyle(height: 2, fontSize: 20, color: Colors.deepOrangeAccent),
                textAlign: TextAlign.center,
              ),
              QuizList(topic: topic)
            ],
          ),
        ),
      ),
    );
  }
}
