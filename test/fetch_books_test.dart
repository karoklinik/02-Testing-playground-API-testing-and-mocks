import 'package:apitesting/fetch_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'fetch_books_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('should show list of books for success API call', () {
    //arrange
    final mockClient = MockClient();
    //create a mockito reaction- response for fetchBooksURL API
    when(mockClient.get(Uri.parse(fetchBooksURL))).thenAnswer(
      (realInvocation) async => http.Response(
          '{["name": "The 5 Second Rule", "auther": "Mel Robbins"]}',
          200), //success response, data and 200
    );
  });
}
