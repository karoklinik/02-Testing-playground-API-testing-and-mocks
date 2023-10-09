import 'dart:math';

import 'package:apitesting/fetch_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'fetch_books_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('should show list of books for success API call', () async {
    //arrange
    final mockClient = MockClient();
    //create a mockito reaction- response for fetchBooksURL API
    when(mockClient.get(Uri.parse(fetchBooksURL))).thenAnswer(
      (realInvocation) async => http.Response(
          '[{"name": "The 5 Second Rule", "auther": "Mel Robbins", "decription": "In its blurb, The 5 Second Rule promises to teach you how to become confident, break the habit of procrastination and self-doubt, beat fear and uncertainty, and be happier. As big of an ask as that might sound, Robbins more than delivers in this wildly popular self-help book, which is built on the titular 5 second rule: the five seconds you should take every time you need to push yourself. Robbins launched the 5 second rule in her incredibly successful Ted Talk, which has been watched by more than 8 million people around the world.", "amazon": "https://www.amazon.com/dp/B01MUSNFOO?tag=reedwebs-20&linkCode=ogi&th=1&psc=1"}]',
          200), //success response in right for BooksListModel form, data and 200
    );

    //act & assert
    expect(
        await fetchBooks(
            mockClient), //fetchBooks method will use mockClient instead of normal API response
        isA<
            List<
                BooksListModel>>()); //test is this response is in the right form
  });

  test('Shows exception when API call throws error', () {
    //arrange
    final mockClient = MockClient();
    //create a mockito reaction- error response for API call
    when(mockClient.get(Uri.parse(fetchBooksURL))).thenAnswer(
        (realInvocation) async =>
            http.Response('Not Found', 404)); //error response

    //act & assert
    expect(fetchBooks(mockClient),
        throwsException); //expecting exception for this error
  });
}
