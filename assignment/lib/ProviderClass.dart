
import 'package:assignment/Results.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProviderClass with ChangeNotifier {
  final Dio dio = Dio();
  List<Results> resultsList = [];
  bool hasMoreItems = true;
  bool isLoading = false;
  int page = 1;

  List<Results> get results => resultsList;

  Future<void> fetchItems({bool isInitialLoad = false}) async {
    if (isLoading) return;

    isLoading = true;
    if (isInitialLoad) {
      resultsList.clear();
      page = 1;
    }

    try {

      List<Results> results = [];

      Response response = await dio.get("https://randomuser.me/api/?page=$page&results=10");

      var decodedJson = response.data;

      results = (decodedJson['results'] as List)
          .map((resultsJson) => Results.fromJson(resultsJson))
          .toList();

      resultsList.addAll(results);

      if (results.length < 10) {
        hasMoreItems = false;
      } else {
        page++;
      }
    } catch (e) {
      print('Error fetching items: $e');

    }

    isLoading = false;
    notifyListeners();
  }
}