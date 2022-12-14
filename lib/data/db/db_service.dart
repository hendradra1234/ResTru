import 'dart:async';

import 'package:hive/hive.dart';
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/utils/config.dart';

class DbService {
  late Box<dynamic> box;
  late Box<dynamic> theme;

  DbService() {
    box = Hive.box(Config.boxFavorite);
    theme = Hive.box(Config.boxDarkMode);
  }

  Future<List<Restaurant>> getFavorites() async {
    return box.values.toList().cast<Restaurant>();
  }

  Future<List<Restaurant>> toggleFavorite(Restaurant restaurant) async {
    try {
      if (box.get(restaurant.id) == null) {
        box.put(restaurant.id, restaurant);
      } else {
        box.delete(restaurant.id);
      }

      return box.values.toList().cast<Restaurant>();
    } catch (e) {
      throw HiveError(e.toString());
    }
  }

  Future<bool> darkMode(bool value) async {
    theme.put('darkMode', value);
    return value;
  }

  bool isDarkMode() {
    return theme.get('darkMode', defaultValue: false);
  }

  Future<bool> setNotify(bool value) async {
    theme.put('notify', value);
    return value;
  }

  bool isNotify() {
    return theme.get('notify', defaultValue: false);
  }
}