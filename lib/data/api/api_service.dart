import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:restaurant_app/data/model/model.dart';
import 'package:restaurant_app/utils/config.dart';

class ApiService {
  Client? http;
  ApiService({this.http}) {
    http ??= Client();
  }

  Future<ResponseRestaurant> getList() async {
    try {
      const rawUrl = '${Config.baseURL}list';
      final response = await http!.get(Uri.parse(rawUrl));
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode.toString()} $rawUrl');
      }
      return ResponseRestaurant.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseRestaurant> search({String query = ""}) async {
    try {
      final rawUrl = '${Config.baseURL}search?q=$query';
      final response = await http!.get(Uri.parse(rawUrl));
      if (response.statusCode != 200) {
        throw Exception('${response.statusCode.toString()} $rawUrl');
      }
      return ResponseRestaurant.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ResponseRestaurantDetail> getDetail(String id) async {
    final rawUrl = '${Config.baseURL}detail/$id';
    final response = await http!.get(Uri.parse(rawUrl));
    if (response.statusCode != 200) {
      throw Exception('${response.statusCode.toString()} $rawUrl');
      // throw Exception(ConstString.failedGetData);
    }
    return ResponseRestaurantDetail.fromJson(json.decode(response.body));
  }

  Future<ResponseReview> postReview(Review review) async {
    const rawUrl = "${Config.baseURL}review";
    var reviews = jsonEncode(review.toJson());
    final response = await http!.post(
      Uri.parse(rawUrl),
      body: reviews,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": Config.xAuthToken,
      },
    );
    if (response.statusCode != 201) {
      throw Exception('${response.statusCode.toString()} $rawUrl');
    }
    return ResponseReview.fromJson(json.decode(response.body));
  }
}
