import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/CarMakes.dart';

abstract class HttpService {
  static final _httpClient = http.Client();

// -----------------------------------------------------------------------------
// If token expired
//
  static Future<CarMakes?> getCarMakes() async {
    String uriString =
        'https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json';
    print(uriString);

    var headers = <String, String>{};
    headers['Content-Type'] = 'application/json; charset=UTF-8';

    final response =
        await _httpClient.get(Uri.parse(uriString), headers: headers);
    print('getDogBreeds response; ${response.body}');

    var carMakes = CarMakes.fromJson(jsonDecode(response.body));
    return carMakes;
  }
}
