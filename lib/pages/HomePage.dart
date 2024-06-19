import 'package:flutter/material.dart';
import 'package:mdo/helpers/Enums.dart';
import 'package:mdo/models/CarMakes.dart';
import 'package:mdo/pages/LoginPage.dart';

import '../services/HttpService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  CarMakes? _carMakes;

// -----------------------------------------------------------------------------
//
//
  @override
  void initState() {
    super.initState();
    _loadCarMakes();
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Home'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _getApiView(),
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
  Widget _getApiView() {
    if (_carMakes == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _carMakes!.count,
      itemBuilder: (BuildContext context, int index) {
        return Text(_carMakes!.results![index].makeName!);
      },
    );
  }

// -----------------------------------------------------------------------------
//
//
  void _loadCarMakes() {
    _carMakes = null;
    HttpService.getCarMakes().then((value) {
      _carMakes = value;
      setState(() {});
    });
  }

// -----------------------------------------------------------------------------
//
//
  void _onItemTapped(int index) {
    _currentIndex = index;

    if (_currentIndex == HomePageTab.api.index) {
      setState(() {});
    }
    //
    else if (_currentIndex == HomePageTab.login.index) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const LoginPage()));
      return;
    }
  }
}
