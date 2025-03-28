import 'package:childrens_book_app/models/book.dart';
import 'package:childrens_book_app/models/category.dart' as app_models;
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import 'user.dart';

class AppState with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _currentUser;
  List<Book> _books = [];
  List<app_models.Category> _categories = [];
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  List<Book> get books => _books;
  List<app_models.Category> get categories => _categories;

  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    try {
      _currentUser = await _apiService.login(username, password);
      await fetchInitialData();
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchInitialData() async {
    await Future.wait([ 
      fetchCategories(),
      fetchBooks(),
      ]);
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

  void setLoading(bool loading) {
    var isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    setLoading(true);
    
    try {
      _categories = await _apiService.getCategories();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }
   Future<void> fetchBooks() async {
    setLoading(true);
    
    try {
      _books = await _apiService.getBooks();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<List<Book>> fetchBooksByCategory(String category) async {
    setLoading(true);
    
    try {
      final books = await _apiService.getBooksByCategory(category);
      setLoading(false);
      notifyListeners();
      return books;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      return [];
    }
  }

  void logout() {}
}
