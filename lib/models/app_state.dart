import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import 'user.dart';

class AppState with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> login(String username, String password) async {
    try {
      _currentUser = await _apiService.login(username, password);
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      await _apiService.register(username, email, password);
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  fetchInitialData() {}

  void setLoading(bool loading) {
    var isLoading = loading;
    notifyListeners();
  }
}
