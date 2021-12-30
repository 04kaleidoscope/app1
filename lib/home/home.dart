import 'package:flutter/material.dart';
import 'package:app1/login/login.dart';
import 'package:app1/topics/topics.dart';
import 'package:app1/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('> loading...');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('> error')
          );
        } else if (snapshot.hasData) { // snapshot is null when user is not logged in
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}