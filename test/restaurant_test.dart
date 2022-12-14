import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([AppProvider, ApiService])
void main() {
  group('Restaurant Test', () {
    late Restaurant restaurant;
    late ApiService apiService;
    late AppProvider appProvider;

    setUp(() {
      apiService = MockApiService();
      appProvider = MockAppProvider();
      restaurant = Restaurant(
        id: "abc123",
        name: "Restaurant",
        description: "Test 123",
        pictureId: "1",
        city: "Jakarta",
        rating: 4.7,
      );
    });

    test('Should success parsing json', () {
      var result = Restaurant.fromJson(restaurant.toJson());

      expect(result.name, restaurant.name);
    });

    test("Should return restaurant detail from API", () async {
      when(apiService.getDetail(restaurant.id)).thenAnswer((_) async {
        return ResponseRestaurantDetail(
          error: false,
          message: 'success',
          restaurant: restaurant,
        );
      });

      expect(await apiService.getDetail(restaurant.id), isA<ResponseRestaurantDetail>());
    });

    test('Should return favorite restaurant', () {
      when(appProvider.favoriteRestaurants).thenAnswer((realInvocation) {
        List<Restaurant> restaurants = [restaurant];
        return restaurants;
      });
      expect(appProvider.favoriteRestaurants, isA<List<Restaurant>>());
    });
  });
}
