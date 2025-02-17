import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:paragon/job/services/jobApi.dart';
import 'package:paragon/models/job.dart';
import 'package:paragon/models/jobparttemplates.dart';

class JobController extends ChangeNotifier {
  JobController({this.api = const JobApi()});
  JobApi api;

  List<Job> jobs = [];
  List<Job> jobslist = [];
  List<Job> jobsreversed = [];
  List<Job> jobsFinish = [];
  List<Job> eventJobs = [];
  //List<Kpi> kpi = [];
  Job? job;
  DateTime? dateTime;
  JobPartTemplates? jobPartTemplates;

  getListJobs() async {
    jobs.clear();
    jobs = await JobApi.getJobs();
    notifyListeners();
  }

  getListAllJobs(
      {required start,
      required int length,
      required List<String> status,
      required DateTime eventDate,
      required int user_id,
      required int customer_id}) async {
    jobs.clear();
    jobsFinish.clear();
    eventJobs.clear();
    jobslist = await JobApi.getMeJobs(
        start: start,
        length: length,
        status: status,
        user_id: user_id,
        customer_id: customer_id);
    jobsreversed = jobslist.toList().reversed.toList();

    final _jobs = await JobApi.getMeJobs(
        start: start,
        length: length,
        status: status,
        user_id: user_id,
        customer_id: customer_id);
    jobslist = _jobs;
    jobs = _jobs;
    // jobslist = _jobs.toList().reversed.toList();
    // jobs = _jobs.toList().reversed.toList();
    // jobs = _jobs
    //     .where((element) => ['assign','finish','reject'].contains(element.status))
    //     .toList();
    jobsFinish = _jobs;
    // jobsFinish = _jobs.toList().reversed.toList();
    // jobsFinish =
    //     _jobs.where((element) => ['close'].contains(element.status)).toList();
    eventJobs = _jobs
        .where((element) => [eventDate]
            .contains(dateTime = DateFormat('y-M-d').parse(element.pm_date!)))
        .toList().reversed.toList();
    //inspect(eventJobs);
    notifyListeners();
  }

  getJobId({required int id}) async {
    job = await JobApi.getJob(id: id);
    notifyListeners();
  }

  getTemplate({required int job_part_template_id}) async{
    jobPartTemplates = await JobApi.getJobPartTemplate(id: job_part_template_id);
    notifyListeners();
  }

  // getListKpi() async {
  //   kpi.clear();
  //   kpi = await JobApi.getKpi();
  //   notifyListeners();
  // }
}
