import 'package:flutter/material.dart';
import 'package:mdo/pages/home/ApiScreen.dart';
import 'package:mdo/pages/home/LoginInfoScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const ApiScreen(),
    const LoginInfoScreen(),
  ];

// -----------------------------------------------------------------------------
//
//
  @override
  void initState() {
    super.initState();
  }

// -----------------------------------------------------------------------------
//
//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: 'Api', icon: Icon(Icons.api)),
            BottomNavigationBarItem(label: 'Login', icon: Icon(Icons.login)),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _onItemTapped(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
