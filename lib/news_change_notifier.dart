import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_service.dart';

/// A class that extends [ChangeNotifier] to manage and notify listeners about news articles.
class NewsChangeNotifier extends ChangeNotifier {
  /// The service responsible for fetching news articles.
  final NewsService _newsService;

  /// Creates an instance of [NewsChangeNotifier] with the given [NewsService].
  NewsChangeNotifier(this._newsService);

  /// A list of articles fetched from the news service.
  List<Article> _articles = [];

  /// Returns the list of articles.
  List<Article> get articles => _articles;

  /// Indicates whether articles are currently being loaded.
  bool _isLoading = false;

  /// Returns true if articles are being loaded, false otherwise.
  bool get isLoading => _isLoading;

  /// Fetches articles from the news service and updates the state.
  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();
    _articles = await _newsService.getArticles();
    _isLoading = false;
    notifyListeners();
  }
}
