import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {
        'tid': query + index.toString(),
        'name': query + index.toString(),
      };
    });
  }
}

class CitiesService {
  List<String> matches = <String>[];
}
