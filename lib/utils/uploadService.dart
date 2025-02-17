import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:paragon/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future uploadImage(XFile file) async {
  if (Platform.isIOS) {
    DateTime dateTime = DateTime.now();
    final directory = await getTemporaryDirectory();
    final outputFile = File('${directory.path}/temp_image.jpeg');
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path, // Input file path
      outputFile.path, // Output file path
      format: CompressFormat.jpeg,
      quality: 70, // Adjust quality as needed (0-100)
    );
    if (result == null) {
      throw Exception("Upload image failed please try again.");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(result.path,
          filename: '${dateTime}.jpeg'),
      'path': '/images/job/',
    });
    // Step 4: Make the POST request
    final res = await Dio().post(
      '$pubUrl/api/upload_images',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    // Step 5: Handle response
    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data['data'];
    } else {
      throw Exception('อัพโหดลไฟล์ล้มเหลว');
    }
  } else {
    print('Not running on iOS.');
    DateTime dateTime = DateTime.now();
    final directory = await getTemporaryDirectory();
    final outputFile = File('${directory.path}/temp_image.jpeg');
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path, // Input file path
      outputFile.path, // Output file path
      format: CompressFormat.jpeg,
      quality: 70, // Adjust quality as needed (0-100)
    );
    if (result == null) {
      throw Exception("Upload image failed please try again.");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(result.path,
          filename: '${dateTime}.jpeg'),
      'path': '/images/job/',
    });
    // Step 4: Make the POST request
    final res = await Dio().post(
      '$pubUrl/api/upload_images',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    // Step 5: Handle response
    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.data['data'];
    } else {
      throw Exception('อัพโหดลไฟล์ล้มเหลว');
    }
  }
}

class UploadResponse {
  UploadResponse({
    required this.fieldname,
    required this.originalname,
    required this.encoding,
    required this.mimetype,
    required this.destination,
    required this.filename,
    required this.path,
    required this.size,
  });
  late final String fieldname;
  late final String originalname;
  late final String encoding;
  late final String mimetype;
  late final String destination;
  late final String filename;
  late final String path;
  late final int size;

  UploadResponse.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    destination = json['destination'];
    filename = json['filename'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fieldname'] = fieldname;
    data['originalname'] = originalname;
    data['encoding'] = encoding;
    data['mimetype'] = mimetype;
    data['destination'] = destination;
    data['filename'] = filename;
    data['path'] = path;
    data['size'] = size;
    return data;
  }
}
