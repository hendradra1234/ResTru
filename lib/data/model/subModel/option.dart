part of '../model.dart';

@HiveType(typeId: 2)

class Option {

  @HiveField(0)
  late String? name;

  Option({
    this.name,
  });

  Option.fromJson(Map<String, dynamic> option) {
    name = option['name'];
  }

  Map<String, dynamic> toJson() => {
      "name": name,
    };
}
