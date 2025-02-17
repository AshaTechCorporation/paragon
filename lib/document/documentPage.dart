import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/document/accountExpire.dart';
import 'package:paragon/document/pdfDocumentPage.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/job/services/jobController.dart';
import 'package:paragon/models/job.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  String pathPDF = "";
  User? user;

  List<Job> jobList = [];
  int initialLoadCount = 4;
  int additionalLoadCount = 4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getPmJobs());
  }

  Future<void> getPmJobs() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
      });
      final List<String> status = ['close'];
      await context.read<JobController>().getListAllJobs(start: 0, length: initialLoadCount, status: status, eventDate: DateTime.now(), user_id: user!.id, customer_id: 0);
      jobList = context.read<JobController>().jobs.toList().reversed.toList();
      LoadingDialog.close(context);
    } catch (e) {
      LoadingDialog.close(context);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('แจ้งเตือน'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(isPhone(context) ? size.height * 0.14 : size.height * 0.10),
            child: Container(
              height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/red_appBar_pic.png'), fit: BoxFit.fill),
              ),
              child: Center(
                child: Text(
                  'เอกสาร PM',
                  style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          body: Consumer<JobController>(builder: (context, jobcontroller, child) {
            final jobPm = jobcontroller.jobsFinish;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  jobPm.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                jobPm.length,
                                (index) => Padding(
                                      padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
                                      child: Container(
                                        //height: size.height * 0.22,
                                        width: size.width * 0.90,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (jobPm[index].exp_status == true) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountExpire()));
                                            } else {
                                              final pdfPath = 'https://power-pm-api.dev-asha.com/api/job_pdf?job_id=${jobPm[index].id}';
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PdfDocumentPage(
                                                            path: pathPDF,
                                                            pathPdf: pdfPath,
                                                          )));
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
                                                    child: jobPm[index].image != null
                                                    ?Image.network(
                                                      jobPm[index].image!,
                                                      height: size.height * 0.165,
                                                      fit: BoxFit.fill,
                                                    ):Image.asset('assets/images/logo.png', fit: BoxFit.fill, height: size.height * 0.165,),
                                                  )),
                                              Expanded(
                                                  flex: 7,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          jobPm[index].pm_date!,
                                                          style: TextStyle(
                                                            color: kTextDateColor,
                                                            fontSize: isPhone(context) ? 16.63 : 26,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   'เอกสารการเข้า PM : ${jobPm[index].po_no}',
                                                        //   style: TextStyle(
                                                        //     color: kTextForgotPasswordColor,
                                                        //     fontSize: isPhone(context) ? 15 : 25,
                                                        //   ),
                                                        // ),
                                                        Text(
                                                          'เอกสารเข้า PM : ${jobPm[index].po_no}',
                                                          style: TextStyle(
                                                            color: kTextForgotPasswordColor,
                                                            fontSize: isPhone(context) ? 15 : 25,
                                                          ),
                                                        ),
                                                        Text(
                                                          '๋Job No : ${jobPm[index].code}',
                                                          style: TextStyle(
                                                            color: kTextForgotPasswordColor,
                                                            fontSize: isPhone(context) ? 15 : 25,
                                                          ),
                                                        ),
                                                        Text(
                                                          'ประเภท : ${jobPm[index].work_type!.name}',
                                                          style: TextStyle(
                                                            color: kTextForgotPasswordColor,
                                                            fontSize: isPhone(context) ? 15 : 25,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'สถานะ : ',
                                                              style: TextStyle(
                                                                color: kTextForgotPasswordColor,
                                                                fontSize: isPhone(context) ? 15 : 25,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: jobPm[index].exp_status == true ? kStatusEndColor : kStatusWaitColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                              //color: ducuments[index]['status'] == 'ดำเนินการ' ?kStatusWaitColor : kStatusEndColor,
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: size.height * 0.005, horizontal: size.width * 0.04),
                                                                child: jobPm[index].exp_status == true
                                                                ?Text(
                                                                  'Expire',
                                                                  style: TextStyle(color: kNaviPrimaryColor, fontSize: isPhone(context) ? 10 : 19, fontWeight: FontWeight.bold),
                                                                )
                                                                :Text(
                                                                  'Active',
                                                                  style: TextStyle(color: kNaviPrimaryColor, fontSize: isPhone(context) ? 10 : 19, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            );
          })),
    );
  }
}
