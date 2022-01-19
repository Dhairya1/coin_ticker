import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final List<dynamic> url;

  Future<List<dynamic>> getData() async {
    if (kDebugMode) {
      print(url);
    }

    http.Response response1 = await http.get(Uri.parse(url[0]));
    http.Response response2 = await http.get(Uri.parse(url[1]));
    http.Response response3 = await http.get(Uri.parse(url[2]));
    if ((response1.statusCode == 200) & (response2.statusCode == 200) & (response3.statusCode == 200)) {
      var first = jsonDecode(response1.body);
      var second = jsonDecode(response2.body);
      var third = jsonDecode(response3.body);
      return [first, second, third];
    } else {
      if (kDebugMode) {
        print(response1.statusCode);
      }
      return [];
    }
  }
}