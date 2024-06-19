import 'package:flutter/material.dart';
import 'package:mdo/models/CarMakes.dart';

import '../services/HttpService.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CarMakes? _carMakes;

// -----------------------------------------------------------------------------
//
//
  @override
  void initState() {
    super.initState();
    HttpService.getCarMakes().then((value) {
      _carMakes = value;
      setState(() {});
    });
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _getMainView(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: 'Api', icon: Icon(Icons.api)),
            BottomNavigationBarItem(label: 'Login', icon: Icon(Icons.login)),
          ],
        ),
      ),
    );
  }

// -----------------------------------------------------------------------------
//
//
  Widget _getMainView() {
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
}
