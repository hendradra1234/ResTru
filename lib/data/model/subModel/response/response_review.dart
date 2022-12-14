part of '../../model.dart';

class ResponseReview {
  bool error;
  String message;
  List<Review> customerReviews;

  ResponseReview({
    required this.error,
    required this.message,
    required this.customerReviews});

  factory ResponseReview.fromJson(Map<String, dynamic> json) => ResponseReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<Review>.from(json["customerReviews"].map((x) => Review.fromJson(x))),
      );
}
