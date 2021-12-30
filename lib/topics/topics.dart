import 'package:app1/services/firestore.dart';
import 'package:app1/services/models.dart';
import 'package:app1/shared/bottom_nav.dart';
import 'package:app1/shared/error.dart';
import 'package:app1/shared/loading.dart';
import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber.shade800,
              title: const Text('Products'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: topics.map((topic) => Text(topic.title)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );

        } else {
          return const Text('no topics in firestore, check db');
        }
      },
    );
    
    
    
    
     //Scaffold(      bottomNavigationBar: BottomNavBar(),);
  }
}