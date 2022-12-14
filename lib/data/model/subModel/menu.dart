part of '../model.dart';


enum MenuType { food, drink }
@HiveType(typeId: 1)
class Menu {

  @HiveField(0)
  List<Option> foods;
  @HiveField(1)
  List<Option> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<Option>.from(json["foods"].map((x) => Option.fromJson(x))),
        drinks: List<Option>.from(json["drinks"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((i) => i.toJson())),
        "drinks": List<dynamic>.from(drinks.map((i) => i.toJson())),
      };
}
