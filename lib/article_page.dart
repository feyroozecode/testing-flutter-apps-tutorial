import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/article.dart';

/// A widget that displays an article's title and content.
class ArticlePage extends StatelessWidget {
  /// The article to be displayed.
  final Article article;

  /// Creates an instance of [ArticlePage].
  ///
  /// The [article] parameter is required and must not be null.
  const ArticlePage({
    required this.article,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the media query data for responsive design
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mq.padding.top,
          bottom: mq.padding.bottom,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            // Display the article title
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Display the article content
            Text(article.content),
          ],
        ),
      ),
    );
  }
}
