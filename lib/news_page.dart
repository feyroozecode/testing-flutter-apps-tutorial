import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_testing_tutorial/article_page.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';

/// A page that displays a list of news articles.
class NewsPage extends StatefulWidget {
  /// Creates a [NewsPage].
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  
  @override
  void initState() {
    super.initState();
    // Fetch articles when the widget is initialized.
    Future.microtask(
      () => context.read<NewsChangeNotifier>().getArticles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the NewsPage.
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh articles when the refresh button is pressed.
              context.read<NewsChangeNotifier>().getArticles();
            },
          ),
        ],
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                key: Key('progress-indicator'),
              ),
            );
          }
          return ListView.builder(
            itemCount: notifier.articles.length,
            itemBuilder: (_, index) {
              final article = notifier.articles[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    // Navigate to the ArticlePage when an article is tapped.
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticlePage(article: article),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      article.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
          );
        },
      ),
    );
  }
}
