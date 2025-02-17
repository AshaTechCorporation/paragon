import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/models/auth.dart';
import 'package:paragon/models/customer.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  const LoginApi();

  //login
  static Future<Auth> login(String email, String password, String device_no, String notify_token) async {
    final url = Uri.https(publicUrl, '/api/login');
    final response = await http.post(url, body: convert.jsonEncode({
      'email': email,
      'password': password,
      'device_no': device_no,
      'notify_token': notify_token,
    }));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Auth.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //reset Password
  static Future resetPassWord(
    int id,
    String password,
    String new_password,
    String confirm_new_password,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    final url = Uri.https(publicUrl, 'api/reset_password_user/$id');
    final response = await http.put(url, headers: headers, body: {
      'password': password,
      'new_password': new_password,
      'confirm_new_password': confirm_new_password,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //forgot Password
  static Future forgotPassword(String email) async {
    final url = Uri.https(publicUrl, 'api/forgot_password_user');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'email': email,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data['status'];
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //get customer
  static Future<List<Customer>> getCustomer() async {
    final url = Uri.https(publicUrl, 'api/get_customer');
    //print(token);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final list = data['data'] as List;
      return list.map((e) => Customer.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //register
  static register({
    required XFile? file,
    required String user_id,
    required String password,
    required String name,
    required String tel,
    required String email,
    required String register_date,
    required int customer_id,
    required String company_name,
    required String company_address,
    required String company_email,
    required String company_tax,
    required String company_tel,
  }) async {
    var formData;
    if (file == null) {
      formData = FormData.fromMap(
        {
          'image': null,
          "name": name,
          "user_id": user_id,
          "password": password,
          "tel": tel,
          "register_date": register_date,
          "customer_id": customer_id,
          "email": email,
          "company_tax": company_tax,
          "company_name": company_name,
          "company_address": company_address,
          "company_tel": company_tel,
          "company_email": company_email
        },
      );
    } else {
      formData = FormData.fromMap(
        {
          'image': await MultipartFile.fromFile(file.path, filename: file.name),
          "name": name,
          "user_id": user_id,
          "password": password,
          "tel": tel,
          "register_date": register_date,
          "customer_id": customer_id,
          "email": email,
          "company_tax": company_tax,
          "company_name": company_name,
          "company_address": company_address,
          "company_tel": company_tel,
          "company_email": company_email
        },
      );
    }
    final res = await Dio().post(
      '$pubUrl/api/register_user_customer',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data['data'];
    } else {
      throw Exception('แก้ใขโปรไฟล์ล้มเหลว');
    }
  }
}
