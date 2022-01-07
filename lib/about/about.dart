import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Image.network('https://www.pngkit.com/png/detail/381-3815811_9d5-badly-drawn-thinking-emoji.png')
    );
  }
}