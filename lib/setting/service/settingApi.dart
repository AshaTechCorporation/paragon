import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/models/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class SettingApi {
  const SettingApi();

  static editProfile({required String image, required String name, required String email, required String tel}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    final url = Uri.https(publicUrl, 'api/update_profile_user');
    final response = await http.put(url,
        headers: headers, body: convert.jsonEncode({"image": image, "name": name, "email": email, "tel": tel}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data['code'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  static editProfileUser(
      {required XFile? file, required String name, required String email, required String tel}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var formData;
    if (file == null) {
      formData = FormData.fromMap(
        {'image': null, "name": name, "email": email, "tel": tel},
      );
    } else {
      formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(file.path, filename: file.name),
          "name": name,
          "email": email,
          "tel": tel
        },
      );
    }

    final res = await Dio().post('$pubUrl/api/update_profile_user',
        data: formData, options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data['code'];
    } else {
      throw Exception('แก้ใขโปรไฟล์ล้มเหลว');
    }
  }

  static Future getPrivacy(int id) async {
    final url = Uri.https(publicUrl, '/api/config/1');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Config.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  static Future deletAccount(int id) async {
    final url = Uri.https(publicUrl, '/api/user/$id');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data['code'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }
}
