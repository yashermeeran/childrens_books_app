import 'book.dart';

class Bookmark {
  final int id;
  final int userId;
  final int bookId;
  final int pageNumber;
  final DateTime createdAt;
  Book? book;

  Bookmark({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.pageNumber,
    required this.createdAt,
    this.book,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      userId: json['userId'],
      bookId: json['bookId'],
      pageNumber: json['pageNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'pageNumber': pageNumber,
    };
  }
}
