import 'package:flutter/material.dart';
import 'package:mdo/pages/home/tabs/ApiTab.dart';
import 'package:mdo/pages/home/tabs/LoginInfoTab.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const ApiTab(),
    const LoginInfotab(),
  ];

// -----------------------------------------------------------------------------
//
//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _tabs[_currentIndex],
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

    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
