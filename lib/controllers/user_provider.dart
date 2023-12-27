// third_screen_controller.dart
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/dio_service.dart';

class UserProvider with ChangeNotifier {
  late List<User> _userData;
  late String _username;
  List<User> get userData =>_userData;
  String get username => _username;

  int currentPage = 1;
  bool isLoading = false;
  late ScrollController scrollController;

  UserProvider() {
    _userData = [];
    _username = "";
    scrollController = ScrollController()..addListener(_scrollListener);
    _fetch_userData();
  }

  set username(String name) {
    _username = name;
    notifyListeners();
  }

  Future<void> _fetch_userData() async {
    try {
      isLoading = true;
      notifyListeners();

      List<User> users = await ApiService.fetchUserData(currentPage);

      _userData.addAll(users);
      currentPage++;
    } catch (error) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    currentPage = 1;
    _userData.clear();
    await _fetch_userData();
  }

  void _scrollListener() {
    if (!scrollController.position.outOfRange &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      _fetch_userData();
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}
