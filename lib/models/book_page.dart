class BookPage {
  final int pageNumber;
  final String text;

  BookPage({
    required this.pageNumber,
    required this.text,
  });

  factory BookPage.fromJson(Map<String, dynamic> json, int pageNumber) {
    return BookPage(
      pageNumber: json['pageNumber'] ?? 0,
      text: json['content'] ?? '',
    );
  }
}
