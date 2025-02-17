import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:paragon/constants.dart';
import 'package:paragon/models/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyApi {
  const NotifyApi();

  static Future<List<Notify>> getMeJobs({
    required start,
    required int length,
    required int user_id
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final url = Uri.https(publicUrl, 'api/notify_log_user_page');
    final response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode({
          "user_id": user_id,
          "draw": 1,
          "columns": [],
          "order": [
            {"column": 0, "dir": "desc"}
          ],
          "start": start,
          "length": length,
          "search": {"value": "", "regex": false}
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      final list = data['data']['data'] as List;
      return list.map((e) => Notify.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
