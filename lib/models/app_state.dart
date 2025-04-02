import 'package:childrens_book_app/models/book.dart';
import 'package:childrens_book_app/models/book_page.dart';
import 'package:childrens_book_app/models/bookmark.dart';
import 'package:childrens_book_app/models/category.dart' as app_models;
import 'package:childrens_book_app/models/user.dart';
import 'package:childrens_book_app/services/api_service.dart';
import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _currentUser;
  List<Book> _books = [];
  List<app_models.Category> _categories = [];
  List<Bookmark> _bookmarks = [];
  Map<int, List<BookPage>> _bookPages = {};
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  List<Book> get books => _books;
  List<app_models.Category> get categories => _categories;
  List<Bookmark> get bookmarks => _bookmarks;
  bool get isLoading => _isLoading;

  List<Book> getBooksByCategory(String category) {
    return _books.where((book) => book.category == category).toList();
  }

  Future<bool> checkLoginStatus() async {
    final bool isLoggedIn = await _apiService.isLoggedIn();
    return isLoggedIn;
  }

  Future<bool> login(String userName, String password) async {
    try {
      _currentUser = (await _apiService.login(userName, password)) as User?;
      await fetchInitialData();
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

  Future<void> logout() async {
    await _apiService.clearToken();
    _currentUser = null;
    _books = [];
    _categories = [];
    _bookmarks = [];
    _bookPages = {};
    notifyListeners();
  }

  Future<void> fetchInitialData() async {
    await Future.wait([
      fetchCategories(),
      fetchBooks(),
      fetchBookmarks(),
    ]);
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

  Future<Book?> fetchBookDetails(int bookId) async {
    setLoading(true);

    try {
      final book = await _apiService.getBookDetails(bookId);
      setLoading(false);
      notifyListeners();
      return book;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      return null;
    }
  }

  Future<List<BookPage>> fetchBookContent(int bookId) async {
    setLoading(true);

    try {
      if (_bookPages.containsKey(bookId)) {
        setLoading(false);
        return _bookPages[bookId]!;
      }

      final totalPages = await _apiService.getBookTotalPages(bookId);

      List<BookPage> pages = [];
      for (int i = 1; i <= totalPages; i++) {
        final page = await _apiService.getBookContent(bookId, i);
        pages.add(page);
      }

      _bookPages[bookId] = pages;

      setLoading(false);
      notifyListeners();
      return pages;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      return [];
    }
  }

  Future<BookPage> fetchBookPage(int bookId, int pageNumber) async {
    setLoading(true);

    try {
      final page = await _apiService.getBookContent(bookId, pageNumber);
      setLoading(false);
      notifyListeners();
      return page;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<int> fetchBookTotalPages(int bookId) async {
    setLoading(true);

    try {
      final totalPages = await _apiService.getBookTotalPages(bookId);
      setLoading(false);
      notifyListeners();
      return totalPages;
    } catch (e) {
      setLoading(false);
      notifyListeners();
      return 0;
    }
  }

  Future<void> fetchBookmarks() async {
    setLoading(true);

    try {
      _bookmarks = await _apiService.getBookmarks();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setLoading(false);
      notifyListeners();
    }
  }

  bool isPageBookmarked(int bookId, int pageNumber) {
    return _bookmarks.any((bookmark) =>
        bookmark.bookId == bookId && bookmark.pageNumber == pageNumber);
  }

  Bookmark? getBookmarkForPage(int bookId, int pageNumber) {
    try {
      return _bookmarks.firstWhere((bookmark) =>
          bookmark.bookId == bookId && bookmark.pageNumber == pageNumber);
    } catch (e) {
      return null;
    }
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
