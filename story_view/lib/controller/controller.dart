import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_view_task/model/story_model.dart';
import 'package:story_view_task/view/const/token.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> storyData = [];
  Future<void> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('results')) {
            final List<dynamic> categoryDataList = jsonResponse['results'];
            storyData = categoryDataList
                .map((categoryData) => Category.fromJson(categoryData))
                .toList();
            notifyListeners();
            return;
          }
        }
        throw Exception('Invalid response format');
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
