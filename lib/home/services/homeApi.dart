import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:paragon/constants.dart';
import 'dart:convert' as convert;

import 'package:paragon/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApi {
  const HomeApi();

  //get profile user
  static Future<User> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(publicUrl, 'api/get_profile_user');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    print(token);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return User.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  // static Future<List<News>> getNews() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.https(publicUrl, 'api/get_news');
  //   final response = await http.get(
  //     url,
  //     headers: {'Authorization': 'Bearer $token'},
  //   );
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     final list = data['data'] as List;
  //     return list.map((e) => News.fromJson(e)).toList();
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }

  // static Future<News> getNewsId(int id) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.https(publicUrl, 'api/news/$id');
  //   final response = await http.get(
  //     url,
  //     headers: {'Authorization': 'Bearer $token'},
  //   );
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     return News.fromJson(data['data']);
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }

  // static Future<List<Promotion>> getPromotions() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.https(publicUrl, 'api/get_promotion');
  //   final response = await http.get(
  //     url,
  //     headers: {'Authorization': 'Bearer $token'},
  //   );
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     final list = data['data'] as List;
  //     return list.map((e) => Promotion.fromJson(e)).toList();
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }
}