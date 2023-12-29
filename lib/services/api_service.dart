// user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';


class ApiService {
  static Future<List<User>> fetchUserData(int currentPage) async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$currentPage&per_page=10'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> newUserList = data['data'];
      return newUserList.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
