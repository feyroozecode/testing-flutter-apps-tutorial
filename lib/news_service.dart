import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_testing_tutorial/article.dart';

/// A News service simulating communication with a server.
class NewsService {
  /// In-memory list of articles that simulates a remote database.
  /// Generates 10 articles with random lorem ipsum text for both
  /// title and content.

  final _articles = List.generate(
    10,
    (_) => Article(
      title: lorem(paragraphs: 1, words: 3), // Generate a 3-word title
      content: lorem(
          paragraphs: 7, words: 500), // Generate content with 10 paragraphs
    ),
  );

  /// Fetches all articles from the simulated database.
  ///
  /// Adds an artificial delay of 1 second to simulate network latency.
  ///
  /// Returns:
  ///   Future<List<Article>>: A list of Article objects after the delay.
  Future<List<Article>> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articles;
  }
  
}
