import 'package:app1/routes.dart';
import 'package:app1/services/firestore.dart';
import 'package:app1/services/models.dart';
import 'package:app1/theme.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(myApp());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class myApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<myApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Future<void> _initialization2 = FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '6LfJp6AfAAAAAKfCmlZlwTHpf8J8erxlUZQHShOH',
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Directionality(
            textDirection: TextDirection.ltr,
            child: Text('unable to connect with firebase'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
              future: _initialization2,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(snapshot.error.toString()));
                }

                return StreamProvider(
                  create: (_) => FirestoreService().streamReport(),
                  initialData: Report(),
                  child: MaterialApp(
                    routes: appRoutes,
                    theme: appTheme,
                  ),
                );
              });
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Text('loading...'),
        );
      },
    );
  }
}
