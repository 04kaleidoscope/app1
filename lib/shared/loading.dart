import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 150,
      height: 150,
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loader(),
      ),
    );
  }
}