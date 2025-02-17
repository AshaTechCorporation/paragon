import 'package:http/http.dart' as http;
import 'package:paragon/constants.dart';
import 'package:paragon/models/job.dart';
import 'package:paragon/models/jobparttemplatedetail.dart';
import 'package:paragon/models/jobparttemplates.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class JobApi {
  const JobApi();

  static Future<List<Job>> getJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(publicUrl, 'api/get_job');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final list = data['data'] as List;
      return list.map((e) => Job.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// Get List Job
  static Future<List<Job>> getMeJobs({required start, required int length, required List<String> status, required int user_id, required int customer_id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, 'api/job_m_page');
    final response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode({
          "user_id": user_id == 0 ? null : user_id,
          "status": status,
          "work_type_id": null,
          "vendor_id": null,
          "customer_id": customer_id == 0 ? null : customer_id,
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
      return list.map((e) => Job.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// Get Job By Id
  static Future<Job> getJob({required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(publicUrl, 'api/job/$id');
    //print(token);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Job.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// Get JobPartTemplate By Id
  static Future<JobPartTemplates> getJobPartTemplate({required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.https(publicUrl, 'api/get_job_part_template');
    //print(token);
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          "job_part_template_id": id,
        }));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return JobPartTemplates.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// ช่าง บันทึกค่างาน (APP)
  static Future<Job> saveJobFinish({required int id, required List<JobPartTemplateDetail> job_part_tem_detail}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, 'api/finish_job/$id');
    final response = await http.put(url,
        headers: headers,
        body: convert.jsonEncode({
          "job_part_template_detail": job_part_tem_detail,
        }));
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Job.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// คอนเฟิร์มจบงาน (APP ช่าง)
  static Future confirmJob({required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(publicUrl, 'api/confirm_finish_job/$id');
    final response = await http.put(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return Job.fromJson(data['data']);
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  ///// Get KPI
  // static Future<List<Kpi>> getKpi() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.https(publicUrl, 'api/get_evaluation');
  //   final response = await http.get(
  //     url,
  //     headers: {'Authorization': 'Bearer $token'},
  //   );
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     final list = data['data'] as List;
  //     return list.map((e) => Kpi.fromJson(e)).toList();
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }

  ///// ให้คะแนนงาน (APP ลูกค้า)
  // static Future putRatework({required int id, required List<JobEvaluationScore1> job_evaluation_score, required String score_remark, required String score_by}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  //   final url = Uri.https(publicUrl, 'api/evaluate_job/$id');
  //   final response = await http.put(url, headers: headers, body: convert.jsonEncode({"job_evaluation_score": job_evaluation_score, "score_remark": score_remark, "score_by": score_by}));
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     return Job.fromJson(data['data']);
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }

  ///// แจ้งซ่อม
  // static Future reportRepair(
  //     {required int customer_id,
  //     required String date,
  //     required String model,
  //     required String location,
  //     required String equipment_name,
  //     required String casey,
  //     required String contact_person,
  //     required String name,
  //     required String image,
  //     required String image_second,
  //     required String image_third,
  //     required String line_id,
  //     required String tel}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final url = Uri.https(publicUrl, 'api/job_repair');
  //   //print(token);
  //   final response = await http.post(url,
  //       headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
  //       body: convert.jsonEncode({
  //         "customer_id": customer_id,
  //         "date": date,
  //         "model": model, 
  //         "location": location, 
  //         "equipment_name": equipment_name, 
  //         "case": casey, 
  //         "contact_person": contact_person, 
  //         "name": name, 
  //         "line_id": line_id, 
  //         "tel": tel,
  //         "image": image,
  //         "image_second": image_second,
  //         "image_third": image_third,
  //       }));
  //   if (response.statusCode == 200) {
  //     final data = convert.jsonDecode(response.body);
  //     return data['data'];
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }

  ///// Get List Job Repair
  // static Future getJobRepair({required start, required int length, required List<String> status, required int user_id, required int customer_id}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
  //   final url = Uri.https(publicUrl, 'api/job_repair_page');
  //   final response = await http.post(url,
  //       headers: headers,
  //       body: convert.jsonEncode({
  //         "user_id": user_id == 0 ? null : user_id,
  //         "status": null,
  //         "vendor_id": null,
  //         "customer_id": customer_id == 0 ? null : customer_id,
  //         "draw": 1,
  //         "columns": [],
  //         "order": [
  //           {"column": 0, "dir": "desc"}
  //         ],
  //         "start": start,
  //         "length": length,
  //         "search": {"value": "", "regex": false}
  //       }));
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     final data = convert.jsonDecode(response.body);
  //     final list = data['data']['data'] as List;
  //     return list;
  //   } else {
  //     final data = convert.jsonDecode(response.body);
  //     throw Exception(data['message']);
  //   }
  // }
}
