import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/utils/config.dart';

import 'fetch_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('recommendationRestaurant', () {
    test('return a List Restaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('${Config.baseURL}list'))).thenAnswer(
          (_) async => http.Response(
              '{"error": false,"message": "success","count": 20,"restaurants": []}',
              200));

      expect(await ApiService(http: client).getList(),
          isA<ResponseRestaurant>());
    });
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('${Config.baseURL}list')))
          .thenAnswer((_) async => http.Response('Not Found', 200));
      expect(ApiService(http: client).getList(),
          throwsException);
    });
  });
}
