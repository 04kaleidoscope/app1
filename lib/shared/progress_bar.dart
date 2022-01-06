import 'package:flutter/material.dart';
import 'package:app1/services/models.dart';
import 'package:provider/provider.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double value;
  final double height;

  const AnimatedProgressBar(
      {Key? key, required this.value, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(height),
                    )),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _minValue(value),
                decoration: BoxDecoration(
                  color: _colorGenerator(value),
                  borderRadius: BorderRadius.all(Radius.circular(height)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _minValue(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  _colorGenerator(double value) {
    int rgb = (value * 255).toInt();
    return Colors.deepOrangeAccent.withGreen(rgb).withRed(255 - rgb);
  }
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({Key? key, required this.topic}) : super(key: key);
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        _progressCounter(report, topic),
        Expanded(
          child: AnimatedProgressBar(
            value: _calculateProgress(report, topic),
            height: 8,
          ),
        )
      ],
    );
  }

  Widget _progressCounter(Report report, Topic topic) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  double _calculateProgress(Report report, Topic topic) {
    try {
      int total = topic.quizzes.length;
      int completed = report.topics[topic.id].length;
      return completed / total;
    } catch (e) {
      return 0.0;
    }
  }
}
