import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon( 
            FontAwesomeIcons.fire,
            size: 20,
            color: Colors.redAccent,
          ),
          label: 'firequiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.code,
            size: 20,
            color: Colors.orange,
          ),
          label: 'about',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 20,
            color: Colors.yellow,
          ),
          label: 'profile',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
          // nothing because we're here
          break;
          case 1:
          Navigator.pushNamed(context, '/about');
          break;
          case 2:
          Navigator.pushNamed(context, '/profile');
          break;
        }
      },
    );
  }
}
