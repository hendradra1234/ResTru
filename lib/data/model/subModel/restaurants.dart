part of '../model.dart';
@HiveType(typeId: 0)

class Restaurant {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String pictureId;
  @HiveField(4)
  String city;
  @HiveField(5)
  String? address;
  @HiveField(6)
  num rating;
  @HiveField(7)
  List<Categories>? categories;
  @HiveField(8)
  Menu? menus;
  @HiveField(9)
  List<Review>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
    });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      address: json["address"],
      city: json["city"],
      rating: json["rating"],
      categories: json["categories"] == null
          ? null
          : List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
      menus: json['menus'] != null
        ? Menu.fromJson(json["menus"])
        : null,
      customerReviews: json["customerReviews"] == null
          ? null
          : List<Review>.from((json["customerReviews"] as List)
              .map((x) => Review.fromJson(x))
              .where((review) => review.name!.isNotEmpty)));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "address": address,
        "city": city,
        "rating": rating,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((e) => e.toJson())),
        "menus": menus == null ? null : menus!.toJson(),
        "customerReviews": customerReviews == null
            ? null
            : List<dynamic>.from(customerReviews!.map((e) => e.toJson()))
  };

  String getSmallPicture() => Config.imgSmallURL + pictureId;

  String getMediumPicture() => Config.imgMediumURL + pictureId;

  String getLargePicture() => Config.imgLargeURL + pictureId;
}

