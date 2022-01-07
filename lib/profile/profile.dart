import 'package:flutter/material.dart';
import 'package:app1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:app1/services/models.dart';
import 'package:app1/shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.yellow.shade800,
            title: const Text('profile')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text('user: ${user.displayName ?? 'anonymous'}',
                  style: Theme.of(context).textTheme.headline5),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.caption),
              const Spacer(),
              Text('quizzes completed: ${report.total}',
                  style: Theme.of(context).textTheme.headline5),
              const Spacer(),
              const LogoutButton(
                color: Color(0xFFFFA000), // Firebase amber
                icon: Icons.logout_sharp,
                text: 'logout',
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const LoadingScreen();
    }
  }
}

class LogoutButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  const LogoutButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
          onPressed: () async {
            await AuthService().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
          ),
          label: Text(
            text,
            textAlign: TextAlign.center,
          )),
    );
  }
}
