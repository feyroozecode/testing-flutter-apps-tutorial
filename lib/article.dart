/// A simple Article class with a title and content.
class Article {
  final String title;
  final String content;

  Article({
    required this.title,
    required this.content,
  });

  /// Creates a copy of this article with the given fields replaced with the new values.
  Article copyWith({
    String? title,
    String? content,
  }) {
    return Article(
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  String toString() => 'Article(title: $title, content: $content)';

  /// Compares two articles based on their titles and contents.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article && other.title == title && other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}
