import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_page.dart';
import 'package:flutter_testing_tutorial/news_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

/// A mock implementation of the [NewsService] class using mocktail.
class MockNewsService extends Mock implements NewsService {}

void main() {
  /// Mock instance of [NewsService] used to simulate backend behavior.
  late MockNewsService mockNewsService;

  /// Sets up the test environment by initializing [mockNewsService].
  setUp(() {
    mockNewsService = MockNewsService();
  });

  /// A sample list of articles that the mock service will return.
  final articlesFromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content')
  ];

  /// Configures the mock service to return three articles immediately.
  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles()).thenAnswer(
      (_) async => articlesFromService,
    );
  }

  /// Configures the mock service to return three articles after a 2-second delay.
  void arrangeNewsServiceReturns3ArticlesAfter2SecondWait() {
    when(() => mockNewsService.getArticles()).thenAnswer(
      (_) async {
        await Future.delayed(const Duration(seconds: 2));
        return articlesFromService;
      },
    );
  }

  /// Creates the widget under test, a MaterialApp wrapped with a
  /// [ChangeNotifierProvider] to inject the mock [NewsService].
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  /// Test to verify that the app title "News" is displayed correctly.
  testWidgets(
    "title is displayed",
    (WidgetTester tester) async {
      // Arrange
      arrangeNewsServiceReturns3Articles();

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('News'), findsOneWidget);
    },
  );

  /// Test to verify that a loading indicator is displayed while waiting for articles to load.
  testWidgets(
    "loading indicator is displayed while waiting for articles",
    (WidgetTester tester) async {
      // Arrange
      arrangeNewsServiceReturns3ArticlesAfter2SecondWait();

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Simulate time passage for 500ms
      await tester.pump(const Duration(milliseconds: 500));

      // Assert
      expect(find.byKey(const Key('progress-indicator')), findsOneWidget);

      // Wait for all animations to complete
      await tester.pumpAndSettle();
    },
  );

  /// Test to verify that articles are displayed correctly after being loaded.
  testWidgets(
    "articles are displayed",
    (WidgetTester tester) async {
      // Arrange
      arrangeNewsServiceReturns3Articles();

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Allow the widget tree to rebuild
      await tester.pump();

      // Assert
      for (final article in articlesFromService) {
        // Check if each article's title and content are found
        expect(find.text(article.title), findsOneWidget);
        expect(find.text(article.content), findsOneWidget);
      }
    },
  );
}
