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
import 'package:paragon/models/user.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PmHistoryPage extends StatefulWidget {
  const PmHistoryPage({super.key});

  @override
  State<PmHistoryPage> createState() => _PmHistoryPageState();
}

class _PmHistoryPageState extends State<PmHistoryPage> {
  String pathPDF = "";
  User? user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getPmJobs());
    // fromAsset('assets/images/Spec-Server.pdf', 'demo.pdf').then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //   });
    // });
  }

  // Future<File> fromAsset(String asset, String filename) async {
  //   // To open from assets, you can copy them to the app storage folder, and the access them "locally"
  //   Completer<File> completer = Completer();

  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     File file = File("${dir.path}/$filename");
  //     var data = await rootBundle.load(asset);
  //     var bytes = data.buffer.asUint8List();
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }

  //   return completer.future;
  // }

  Future<void> getPmJobs() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
      });
      final List<String> status = ['close'];
      await context.read<JobController>().getListAllJobs(
          start: 0, length: 10, status: status, eventDate: DateTime.now(), user_id: user!.permission_id == 1 ? user!.id : 0, customer_id: user!.type == "customer" ? user!.customer_id! : 0);
      //await context.read<JobController>().getListJobs();
      LoadingDialog.close(context);
    } on Exception catch (e) {
      LoadingDialog.close(context);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'แจ้งเตือน',
          description: '${e.getMessage}',
          pressYes: () {
            Navigator.pop(context, true);
          },
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
                image: DecorationImage(image: AssetImage('$part_image'), fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.01),
                    child: BackButtonOnClick(
                      size: size,
                      press: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                  Text(
                    'ประวัติPM',
                    style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: isPhone(context) ? size.height * 0.05 : size.height * 0.07,
                    width: isPhone(context) ? size.width * 0.12 : size.width * 0.14,
                  )
                ],
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
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  jobPm.length,
                                  (index) => Padding(
                                        padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
                                        child: Container(
                                          //height: size.height * 0.22,
                                          width: size.width * 0.92,
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
                                              // if (jobPm[index].status ==
                                              //     'close') {
                                              //   final pdfPath =
                                              //       'https://powertech-control-api.dev-asha.com/api/job_pdf?job_id=${jobPm[index].id}';
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               PdfDocumentPage(
                                              //                 path: pathPDF,
                                              //                 pathPdf: pdfPath,
                                              //               )));
                                              // } else {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               AccountExpire()));
                                              // }
                                              if (jobPm[index].exp_status == true) {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AccountExpire()));
                                              } else {
                                                final pdfPath = 'https://powertech-control-api.dev-asha.com/api/job_pdf?job_id=${jobPm[index].id}';
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
                                                        height: size.height * 0.15,
                                                        fit: BoxFit.fill,
                                                      ):Image.asset(
                                                        'assets/images/logo.png',
                                                        height: size.height * 0.15,
                                                        fit: BoxFit.fill,
                                                      ),
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
                                                          Text(
                                                            'เอกสารการเข้า PM : ${jobPm[index].po_no}',
                                                            style: TextStyle(
                                                              color: kTextForgotPasswordColor,
                                                              fontSize: isPhone(context) ? 15 : 25,
                                                            ),
                                                          ),
                                                          Text(
                                                            'เลขสินค้า : ${jobPm[index].code}',
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
                                                                    color: jobPm[index].status == 'finish' ? kStatusWaitColor : kStatusEndColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                //color: ducuments[index]['status'] == 'ดำเนินการ' ?kStatusWaitColor : kStatusEndColor,
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: size.height * 0.005, horizontal: size.width * 0.04),
                                                                  child: Text(
                                                                    '${jobPm[index].status}',
                                                                    style: TextStyle(color: kNaviPrimaryColor, fontSize: isPhone(context) ? 9.73 : 19, fontWeight: FontWeight.bold),
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
                          ),
                        )
                      : SizedBox(),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: List.generate(
                  //         pmHistory.length,
                  //         (index) => Padding(
                  //               padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  //               child: Container(
                  //                 height: size.height * 0.235,
                  //                 width: size.width * 0.95,
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.all(
                  //                     Radius.circular(15.0),
                  //                   ),
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       offset: Offset(0, 0),
                  //                       blurRadius: 2,
                  //                       spreadRadius: 2,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 child: GestureDetector(
                  //                   onTap: () {},
                  //                   child: Row(
                  //                     children: [
                  //                       Expanded(flex: 4, child: Image.asset(pmHistory[index]['image'])),
                  //                       Expanded(
                  //                           flex: 6,
                  //                           child: Padding(
                  //                             padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                  //                             child: Column(
                  //                               mainAxisAlignment: MainAxisAlignment.start,
                  //                               crossAxisAlignment: CrossAxisAlignment.start,
                  //                               children: [
                  //                                 Text('PO.NO : ${pmHistory[index]['pm_no']}', style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                 Text('JOB.NO : ${pmHistory[index]['job_no']}', style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                 Text('PM Test Date : ${pmHistory[index]['date']}', style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                 Text('สถานที่ : ${pmHistory[index]['location']}', style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                 Text('ผู้รับผิดชอบ : ${pmHistory[index]['person']}', style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                 Row(
                  //                                   children: [
                  //                                     Text(
                  //                                       'สถานะ : ',
                  //                                       style: TextStyle(
                  //                                         color: kTextForgotPasswordColor,
                  //                                         fontSize: isPhone(context) ? 14 : 24,
                  //                                       ),
                  //                                     ),
                  //                                     Text('${pmHistory[index]['status']}', style: TextStyle(color: kStatusWaitColor, fontSize: isPhone(context) ? 14 : 24)),
                  //                                   ],
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: size.height * 0.01,
                  //                                 ),
                  //                                 Row(
                  //                                   mainAxisAlignment: MainAxisAlignment.center,
                  //                                   children: [
                  //                                     Text(
                  //                                       'ดูรายละเอียดเพิ่มเติม',
                  //                                       style: TextStyle(color: kButtonContainerColor, fontSize: isPhone(context) ? 12 : 19),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           )),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             )),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                ],
              ),
            );
          })),
    );
  }
}
