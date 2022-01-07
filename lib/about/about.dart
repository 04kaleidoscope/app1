import 'package:app1/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _st = FirebaseStorage.instance;

Future<String> downloadURLExample(img) async {
  String downloadURL = await _st.ref(img).getDownloadURL();
  return downloadURL;
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  final img = 'badly-drawn-thinking-emoji.png';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: downloadURLExample(img),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text('firequiz_'),
              ),
              body: Center(
                  child: SizedBox(
                      height: 500,
                      width: 500,
                      child: Image.network(snapshot.data.toString()))));
        } else {
          return const Text('no topics in firestore, check db');
        }
      },
    );
  }
}
