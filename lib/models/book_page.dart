class BookPage {
  final int pageNumber;
  final String text;
  final int bookId;
  final int totalPages;

  BookPage({
    required this.pageNumber,
    required this.text,
    required this.bookId,
    required this.totalPages,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    return BookPage(
      pageNumber: json['pageNumber'] ?? 1,
      text: json['content'] ?? '',
      bookId: json['bookId'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}
