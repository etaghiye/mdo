import 'package:flutter/material.dart';

import '../../../models/CarMakes.dart';
import '../../../services/HttpService.dart';

class ApiTab extends StatefulWidget {
  const ApiTab({super.key});

  @override
  State<ApiTab> createState() => _ApiTabState();
}

class _ApiTabState extends State<ApiTab> {
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
}
