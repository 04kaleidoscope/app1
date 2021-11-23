import 'package:app1/about/about.dart';
import 'package:app1/home/home.dart';
import 'package:app1/login/login.dart';
import 'package:app1/profile/profile.dart';
import 'package:app1/topics/topics.dart';


var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};