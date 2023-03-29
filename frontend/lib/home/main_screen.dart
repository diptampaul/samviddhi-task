
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:frontend/pages/all-data.dart';
import 'package:frontend/pages/edit_screen.dart';
import 'package:frontend/pages/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLogin = true;

  late int _selected_index = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const AllDataScreen(),
    const EditScreen(),
  ];
  void navButtonTap(int index){
    setState(() {
      _selected_index = index;
    });
  }


  @override
  void initState()
  {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions[_selected_index],
        ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.data_exploration_outlined), activeIcon: Icon(Icons.data_exploration), label: "All Data"),
          BottomNavigationBarItem(icon: Icon(Icons.delete_forever_outlined), activeIcon: Icon(Icons.delete), label: "See or Delete"),
        ],
          currentIndex: _selected_index,
          type: BottomNavigationBarType.shifting,
          onTap: navButtonTap,
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.grey[900],
          unselectedItemColor: Colors.grey[800],),
    );
  }
}

