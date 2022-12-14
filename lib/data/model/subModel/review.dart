part of '../model.dart';
@HiveType(typeId: 4)
class Review {
  Review({
    this.id,
    this.name,
    this.review,
    this.date});

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? review;
  @HiveField(3)
  String? date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] ?? '',
        name: json["name"],
        review: json["review"],
        date: json["date"]  ?? '',
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "review": review, "date": date};
}
