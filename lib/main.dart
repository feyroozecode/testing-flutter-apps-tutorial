import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_page.dart';
import 'package:flutter_testing_tutorial/news_service.dart';

void main() => runApp(MyApp());

/// Root widget of the application
///
/// This stateless widget sets up the basic app structure including:
/// - MaterialApp as the root
/// - Provider for state management
/// - Initial route to NewsPage
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      // Initialize NewsChangeNotifier with NewsService dependency
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}
