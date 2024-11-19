import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_service.dart';
import 'package:mocktail/mocktail.dart';

/// A mock implementation of the [NewsService] class using mocktail.
class MockNewsService extends Mock implements NewsService {}

void main() {
  /// The system under test (SUT), an instance of [NewsChangeNotifier].
  late NewsChangeNotifier sut;

  /// A mock instance of [NewsService] used to simulate backend behavior.
  late MockNewsService mockNewsService;

  /// Sets up the test environment by initializing [mockNewsService]
  /// and injecting it into [NewsChangeNotifier].
  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  /// Test to ensure the initial values of [NewsChangeNotifier] are correct.
  test(
    "initial values are correct",
    () {
      /// [articles] should be an empty list by default.
      expect(sut.articles, []);

      /// [isLoading] should be false initially.
      expect(sut.isLoading, false);
    },
  );

  /// A group of tests related to the [getArticles] method in [NewsChangeNotifier].
  group('getArticles', () {
    /// Sample articles returned by the mock [NewsService].
    final articlesFromService = [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];

    /// A helper function to configure the mock [NewsService] to return
    /// three articles when [getArticles] is called.
    void arrangeNewsServiceReturns3Articles() {
      when(() => mockNewsService.getArticles()).thenAnswer(
        (_) async => articlesFromService,
      );
    }

    /// Test to verify that [getArticles] calls the backend service exactly once.
    test(
      "gets articles using the NewsService",
      () async {
        // Arrange
        arrangeNewsServiceReturns3Articles();

        // Act
        await sut.getArticles();

        // Assert
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );

    /// Test to validate the behavior of [getArticles] in terms of:
    /// - Setting [isLoading] to true during data loading.
    /// - Updating [articles] with the data returned by the service.
    /// - Resetting [isLoading] to false after data is loaded.
    test(
      """indicates loading of data,
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
      () async {
        // Arrange
        arrangeNewsServiceReturns3Articles();

        // Act
        final future = sut.getArticles();

        // Assert
        /// [isLoading] should be true during the loading process.
        expect(sut.isLoading, true);

        await future;

        /// [articles] should match the data returned by the service.
        expect(sut.articles, articlesFromService);

        /// [isLoading] should be false after data is loaded.
        expect(sut.isLoading, false);
      },
    );
  });
}
