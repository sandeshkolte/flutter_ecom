import 'package:flutter/material.dart';
import 'package:flutter_ecom/repository/user_service.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  final _userService = UserService();

  Future<void>? _fetchUserFuture;

  Future<void> get fetchUserFuture {
    return _fetchUserFuture ??= fetchUser();
  }

  Future<void> fetchUser() async {
    _user = await _userService.fetchUser();
    notifyListeners();
  }
}
