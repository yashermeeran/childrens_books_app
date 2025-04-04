import 'dart:convert';
import 'package:childrens_book_app/models/bookmark.dart';
import 'package:childrens_book_app/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import '../models/user.dart';
import '../models/book_page.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5057/api';
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);

    return {
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer $token' : '',
    };
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<void> _saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId.toString());
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userIdKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey) != null;
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<User> login(String userName, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final userId = data['userId'];
      final token = data['token'];

      await _saveToken(token);
      await _saveUserId(userId);

      return User(
        id: userId,
        userName: userName,
        email: '',
        token: token,
      );
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<List<Book>> getBooks() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books: ${response.body}');
    }
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books/category?category=$category'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books by category: ${response.body}');
    }
  }

  // Get book details
  Future<Book> getBookDetails(int bookId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books/$bookId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Book.fromJson(data);
    } else {
      throw Exception('Failed to load book details: ${response.body}');
    }
  }

  // Get book content (single page)
  Future<BookPage> getBookContent(int bookId, int pageNumber) async {
    print('Fetching content for book ID: $bookId, page: $pageNumber');
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books/$bookId/content?page=$pageNumber'),
      headers: headers,
    );

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return BookPage.fromJson(data);
    } else {
      throw Exception('Failed to load book content: ${response.body}');
    }
  }

  // Get total pages for a book
  Future<int> getBookTotalPages(int bookId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books/$bookId/pages'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['totalPages'];
    } else {
      throw Exception('Failed to get total pages: ${response.body}');
    }
  }

  Future<List<Category>> getCategories() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/books/categories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.body}');
    }
  }

  // Get user's bookmarks
  Future<List<Bookmark>> getBookmarks() async {
    final userId = await getUserId();
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/bookmarks/user/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Bookmark.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookmarks: ${response.body}');
    }
  }

  // Add bookmark
  Future<Bookmark> addBookmark(int bookId, int pageNumber) async {
    final userId = await getUserId();
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/bookmarks'),
      headers: headers,
      body: jsonEncode({
        'userId': userId,
        'bookId': bookId,
        'pageNumber': pageNumber,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Bookmark.fromJson(data);
    } else {
      throw Exception('Failed to add bookmark: ${response.body}');
    }
  }

  // Remove bookmark
  Future<Map<String, dynamic>> removeBookmark(int bookmarkId) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl/bookmarks/$bookmarkId'),
      headers: headers,
    );

    print('Response: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to remove bookmark: ${response.body}');
    }
  }
}
