part of '../../model.dart';

class ResponseRestaurantDetail {
  ResponseRestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory ResponseRestaurantDetail.fromJson(Map<String, dynamic> json) => ResponseRestaurantDetail(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromJson(json["restaurant"]));
}
