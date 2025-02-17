// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:paragon/constants.dart';
// import 'package:paragon/home/services/homeController.dart';
// import 'package:paragon/job/services/jobApi.dart';
// import 'package:paragon/models/user.dart';
// import 'package:paragon/setting/pdfreport.dart';
// import 'package:paragon/utils/formattedMessage.dart';
// import 'package:paragon/widgets/AlertDialogYesNo.dart';
// import 'package:paragon/widgets/BackButtonOnClick.dart';
// import 'package:paragon/widgets/LoadingDialog.dart';
// import 'package:provider/provider.dart';

// class RepairHistory extends StatefulWidget {
//   const RepairHistory({super.key});

//   @override
//   State<RepairHistory> createState() => _RepairHistoryState();
// }

// class _RepairHistoryState extends State<RepairHistory> {
//   User? user;
//   dynamic repairJob;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => getUserProfile());
//   }

//   Future<void> getUserProfile() async {
//     LoadingDialog.open(context);
//     try {
//       await context.read<HomeController>().getProfileUser();
//       setState(() {
//         user = context.read<HomeController>().user;
//       });
//       if (!mounted) return;
//       LoadingDialog.close(context);
//       getReportRepairJob();
//     } on Exception catch (e) {
//       if (!mounted) return;
//       LoadingDialog.close(context);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialogYes(
//           title: 'แจ้งเตือน',
//           description: '${e.getMessage}',
//           pressYes: () {
//             Navigator.pop(context, true);
//           },
//         ),
//       );
//     }
//   }

//   Future<void> getReportRepairJob() async {
//     try {
//       final _repairJob = await JobApi.getJobRepair(start: 0, status: [], customer_id: user!.customer_id!, user_id: 0, length: 1000);
//       setState(() {
//         inspect(_repairJob);
//         if (_repairJob != null) {
//           repairJob = _repairJob;
//         }
//       });
//       if (!mounted) return;
//       //LoadingDialog.close(context);
//     } on Exception catch (e) {
//       // if (!mounted) return;
//       // LoadingDialog.close(context);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialogYes(
//           title: 'แจ้งเตือน',
//           description: '${e.getMessage}',
//           pressYes: () {
//             Navigator.pop(context, true);
//           },
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(isPhone(context) ? size.height * 0.14 : size.height * 0.10),
//           child: Container(
//             height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage('assets/images/red_appBar_pic.png'), fit: BoxFit.fill),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.01),
//                   child: BackButtonOnClick(
//                     size: size,
//                     press: () {
//                       Navigator.pop(context, true);
//                     },
//                   ),
//                 ),
//                 Text(
//                   'ประวัติแจ้งซ่อม',
//                   style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: isPhone(context) ? size.height * 0.05 : size.height * 0.07,
//                   width: isPhone(context) ? size.width * 0.12 : size.width * 0.14,
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: size.height * 0.01,
//               ),
//               repairJob != null
//                   ? repairJob.isNotEmpty
//                       ? Padding(
//                           padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: List.generate(
//                                 repairJob.length,
//                                 (index) => Padding(
//                                       padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           final pdfPath = 'https://powertech-control-api.dev-asha.com/api/jobRepairPDF?job_repair_id=${repairJob[index]['id']}';
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => PdfReport(pathPdf: pdfPath)));
//                                         },
//                                         child: Container(
//                                           width: size.width * 0.96,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0),
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 offset: Offset(0, 0),
//                                                 blurRadius: 2,
//                                                 spreadRadius: 2,
//                                                 color: Colors.grey,
//                                               ),
//                                             ],
//                                           ),
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               final pdfPath = 'https://powertech-control-api.dev-asha.com/api/jobRepairPDF?job_repair_id=${repairJob[index]['id']}';
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) => PdfReport(pathPdf: pdfPath)));
//                                             },
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.02),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 3,
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Text(
//                                                           'วันที่ :',
//                                                           style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16.63 : 26, fontWeight: FontWeight.bold),
//                                                         ),
//                                                         Text(
//                                                           'No :',
//                                                           style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16.63 : 26, fontWeight: FontWeight.bold),
//                                                         ),
//                                                         Text(
//                                                           'อาการ :',
//                                                           style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16.63 : 26, fontWeight: FontWeight.bold),
//                                                         ),
//                                                         Text(
//                                                           'สถานะ :',
//                                                           style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16.63 : 26, fontWeight: FontWeight.bold),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 14,
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Text(
//                                                           repairJob[index]['date'],
//                                                           style: TextStyle(
//                                                             color: kTextDateColor,
//                                                             fontSize: isPhone(context) ? 16.63 : 26,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           repairJob[index]['code'],
//                                                           style: TextStyle(
//                                                             color: kTextForgotPasswordColor,
//                                                             fontSize: isPhone(context) ? 16.63 : 26,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           repairJob[index]['case'],
//                                                           style: TextStyle(
//                                                             color: kTextForgotPasswordColor,
//                                                             fontSize: isPhone(context) ? 16.63 : 26,
//                                                           ),
//                                                         ),
//                                                         Text(
//                                                           repairJob[index]['status'],
//                                                           style: TextStyle(
//                                                             color: repairJob[index]['status'] == 'open'
//                                                                 ? kPrimaryColor
//                                                                 : repairJob[index]['status'] == 'assign'
//                                                                     ? kStatusWaitColor
//                                                                     : repairJob[index]['status'] == 'finish'
//                                                                         ? kStatusWaitColor
//                                                                         : kStatusEndColor,
//                                                             fontSize: isPhone(context) ? 16.63 : 26,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )),
//                           ),
//                         )
//                       : SizedBox()
//                   : SizedBox()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
