// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:paragon/constants.dart';
// import 'package:paragon/home/services/homeController.dart';
// import 'package:paragon/job/services/jobController.dart';
// import 'package:paragon/models/jobevaluationscore1.dart';
// import 'package:paragon/models/user.dart';
// import 'package:paragon/utils/formattedMessage.dart';
// import 'package:paragon/widgets/AlertDialogYesNo.dart';
// import 'package:paragon/widgets/BackButtonOnClick.dart';
// import 'package:paragon/widgets/LoadingDialog.dart';
// import 'package:provider/provider.dart';

// class KpiPage extends StatefulWidget {
//   const KpiPage({super.key});

//   @override
//   State<KpiPage> createState() => _KpiPageState();
// }

// class _KpiPageState extends State<KpiPage> {
//   List<JobEvaluationScore1> job_evaluation_score = [];
//   User? user;

//   double score = 0;
//   double initialRating = 4;

//   double score2 = 0;
//   double initialRating2 = 4;

//   double score3 = 0;
//   double initialRating3 = 4;

//   double score4 = 0;
//   double initialRating4 = 4;
//   double? ratingValue;
//   double? ratingdouble;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => getuser());
//     setState(() {
//       score = initialRating;
//       score2 = initialRating2;
//       score3 = initialRating3;
//       score4 = initialRating4;
//     });
//   }

//   // Future<void> getKpiEvaluation() async {
//   //   LoadingDialog.open(context);
//   //   try {
//   //     await context.read<JobController>().getListKpi();
//   //     for (var i = 0; i < context.read<JobController>().kpi.length; i++) {
//   //       job_evaluation_score.add(JobEvaluationScore1(0, 0));
//   //     }
//   //     LoadingDialog.close(context);
//   //   } on Exception catch (e) {
//   //     LoadingDialog.close(context);
//   //     if (!mounted) return;
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) => AlertDialogYes(
//   //         title: 'แจ้งเตือน',
//   //         description: '${e.getMessage}',
//   //         pressYes: () {
//   //           Navigator.pop(context, true);
//   //         },
//   //       ),
//   //     );
//   //   }
//   // }

//   Future<void> getuser() async {
//     LoadingDialog.open(context);
//     try {
//       await context.read<HomeController>().getProfileUser();
//       setState(() {
//         user = context.read<HomeController>().user;
//         // int? scoreAvg = user!.score_avg;
//         // ratingdouble = scoreAvg?.toDouble() ?? 0.0;
//       });

//       LoadingDialog.close(context);
//     } on Exception catch (e) {
//       LoadingDialog.close(context);
//       if (!mounted) return;
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
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(isPhone(context) ? size.height * 0.14 : size.height * 0.10),
//             child: Container(
//               height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage('assets/images/appBar_pic.png'), fit: BoxFit.fill),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.01),
//                     child: BackButtonOnClick(
//                       size: size,
//                       press: () {
//                         Navigator.pop(context, true);
//                       },
//                     ),
//                   ),
//                   Text(
//                     'KPI',
//                     style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: isPhone(context) ? size.height * 0.05 : size.height * 0.07,
//                     width: isPhone(context) ? size.width * 0.12 : size.width * 0.14,
//                   )
//                 ],
//               ),
//             ),
//             // AppBar(
//             //   title: Text(
//             //     'KPI',
//             //     style: TextStyle(color: kTextHeadColor, fontSize: 25),
//             //   ),
//             //   flexibleSpace: Image(
//             //     image: AssetImage('assets/images/appBar_pic.png'),
//             //     fit: BoxFit.fill,
//             //   ),
//             //   backgroundColor: Colors.transparent,
//             //   //toolbarHeight: size.height * 0.20,
//             //   leading: Padding(
//             //     padding: EdgeInsets.symmetric(vertical: size.height * 0.005, horizontal: size.width * 0.010),
//             //     child: BackButtonOnClick(
//             //       size: size,
//             //       press: () {
//             //         Navigator.pop(context);
//             //       },
//             //     ),
//             //   ),
//             // ),
//           ),
//           body: Consumer<JobController>(builder: (context, jobcontroller, child) {
//             final kpiEvaluation = jobcontroller.kpi;
//             return user != null
//                 ? SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Column(
//                             children: [
//                               Center(
//                                   child: user!.image != null
//                                       ? CircleAvatar(
//                                           backgroundImage: NetworkImage(user!.image ?? ""),
//                                           radius: isPhone(context) ? 50 : 70,
//                                         )
//                                       : CircleAvatar(
//                                           backgroundImage: AssetImage('assets/images/user.png'),
//                                           radius: isPhone(context) ? 50 : 70,
//                                         )),
//                               SizedBox(
//                                 height: size.height * 0.02,
//                               ),
//                               Text(
//                                 '${user!.name}',
//                                 style: TextStyle(fontSize: isPhone(context) ? 20 : 35, fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           Text(
//                             context.locale == Locale('th') ? 'คะแนนรวม' : 'Total score',
//                             style: TextStyle(fontSize: isPhone(context) ? 20 : 30),
//                           ),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           user!.score_avg != null
//                               ? Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       IgnorePointer(
//                                         ignoring: true,
//                                         child: RatingBar.builder(
//                                           initialRating: user!.score_avg!,
//                                           minRating: 1,
//                                           direction: Axis.horizontal,
//                                           allowHalfRating: true,
//                                           itemCount: 5,
//                                           itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                                           itemSize: isPhone(context) ? 40 : 60,
//                                           unratedColor: Colors.grey,
//                                           itemBuilder: (context, _) {
//                                             return Image.asset('assets/icons/mingcute_star-fill.png');
//                                           },
//                                           onRatingUpdate: (rating) {
//                                             //print(rating);
//                                             setState(() {
//                                               ;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : SizedBox.shrink(),
//                           SizedBox(
//                             height: size.height * 0.04,
//                           ),
//                           user!.evaluation_scores!.isNotEmpty
//                               ? Wrap(
//                                   direction: Axis.vertical,
//                                   children: List.generate(
//                                     user!.evaluation_scores!.length,
//                                     (index) {
//                                       String? apiValue = user!.evaluation_scores![index].average_score;
//                                       ratingValue = double.tryParse(apiValue!);

//                                       return Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text('${user!.evaluation_scores![index].evaluation!.name}',
//                                               style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 18 : 25, fontWeight: FontWeight.bold)),
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               crossAxisAlignment: CrossAxisAlignment.end,
//                                               children: [
//                                                 IgnorePointer(
//                                                   ignoring: true,
//                                                   child: RatingBar.builder(
//                                                     initialRating: ratingValue!,
//                                                     minRating: 1,
//                                                     direction: Axis.horizontal,
//                                                     allowHalfRating: true,
//                                                     itemCount: 5,
//                                                     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                                                     itemSize: isPhone(context) ? 40 : 60,
//                                                     unratedColor: Colors.grey,
//                                                     itemBuilder: (context, _) {
//                                                       return Image.asset('assets/icons/mingcute_star-fill.png');
//                                                     },
//                                                     onRatingUpdate: (rating) {
//                                                       //print(rating);
//                                                       setState(() {
//                                                         ;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '${ratingValue!}/5.0 ',
//                                                   style: TextStyle(fontSize: isPhone(context) ? 9 : 19),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 )
//                               : SizedBox.shrink(),
//                           SizedBox(
//                             height: size.height * 0.02,
//                           ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.center,
//                           //   crossAxisAlignment: CrossAxisAlignment.end,
//                           //   children: [
//                           //     RatingBar.builder(
//                           //       initialRating: initialRating,
//                           //       minRating: 1,
//                           //       direction: Axis.horizontal,
//                           //       allowHalfRating: true,
//                           //       itemCount: 5,
//                           //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //       unratedColor: Colors.grey,
//                           //       itemSize: isPhone(context) ? 40 : 60,
//                           //       itemBuilder: (context, _) {
//                           //         return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //       },
//                           //       onRatingUpdate: (rating) {
//                           //         print(rating);
//                           //         setState(() {
//                           //           score = rating;
//                           //         });
//                           //       },
//                           //     ),
//                           //     Text(
//                           //       '${score}/5.0 คะเเนน',
//                           //       style: TextStyle(fontSize: isPhone(context) ? 9 : 19),
//                           //     )
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.03,
//                           // ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   children: [
//                           //     Text(
//                           //       'ความตรงต่อเวลา',
//                           //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Row(
//                           //   children: [
//                           //     RatingBar.builder(
//                           //       initialRating: initialRating2,
//                           //       minRating: 1,
//                           //       direction: Axis.horizontal,
//                           //       allowHalfRating: true,
//                           //       itemCount: 5,
//                           //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //       unratedColor: Colors.grey,
//                           //       itemSize: isPhone(context) ? 40 : 60,
//                           //       itemBuilder: (context, _) {
//                           //         return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //       },
//                           //       onRatingUpdate: (rating) {
//                           //         print(rating);
//                           //         setState(() {
//                           //           score2 = rating;
//                           //         });
//                           //       },
//                           //     ),
//                           //   ],
//                           // ),
//                           // Text(
//                           //   '${score2}/5.0 คะเเนน',
//                           //   style: TextStyle(fontSize: isPhone(context) ? 9 : 19),
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   children: [
//                           //     Text(
//                           //       'ความชำนาญในการทำงาน',
//                           //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Row(
//                           //   children: [
//                           //     RatingBar.builder(
//                           //       initialRating: initialRating3,
//                           //       minRating: 1,
//                           //       direction: Axis.horizontal,
//                           //       allowHalfRating: true,
//                           //       itemCount: 5,
//                           //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //       unratedColor: Colors.grey,
//                           //       itemSize: isPhone(context) ? 40 : 60,
//                           //       itemBuilder: (context, _) {
//                           //         return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //       },
//                           //       onRatingUpdate: (rating) {
//                           //         print(rating);
//                           //         setState(() {
//                           //           score3 = rating;
//                           //         });
//                           //       },
//                           //     ),
//                           //   ],
//                           // ),
//                           // Text(
//                           //   '${score2}/5.0 คะเเนน',
//                           //   style: TextStyle(fontSize: isPhone(context) ? 9 : 19),
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   children: [
//                           //     Text(
//                           //       'ความอัธยาศัยดี',
//                           //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Row(
//                           //   children: [
//                           //     RatingBar.builder(
//                           //       initialRating: initialRating4,
//                           //       minRating: 1,
//                           //       direction: Axis.horizontal,
//                           //       allowHalfRating: true,
//                           //       itemCount: 5,
//                           //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //       unratedColor: Colors.grey,
//                           //       itemSize: isPhone(context) ? 40 : 60,
//                           //       itemBuilder: (context, _) {
//                           //         return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //       },
//                           //       onRatingUpdate: (rating) {
//                           //         print(rating);
//                           //         setState(() {
//                           //           score4 = rating;
//                           //         });
//                           //       },
//                           //     ),
//                           //   ],
//                           // ),
//                           // Text(
//                           //   '${score2}/5.0 คะเเนน',
//                           //   style: TextStyle(fontSize: isPhone(context) ? 9 : 19),
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Container(
//                           //   padding: EdgeInsets.all(8.0),
//                           //   width: size.width * 0.95,
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white,
//                           //     borderRadius: BorderRadius.all(
//                           //       Radius.circular(8.0),
//                           //     ),
//                           //     boxShadow: [
//                           //       BoxShadow(
//                           //         offset: Offset(0, 0),
//                           //         blurRadius: 2,
//                           //         spreadRadius: 2,
//                           //         color: Colors.black26,
//                           //       ),
//                           //     ],
//                           //   ),
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //     children: [
//                           //       Text(
//                           //         'จำนวนงานที่สำเร็จ',
//                           //         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //       ),
//                           //       Text(
//                           //         '78 งาน',
//                           //         style: TextStyle(color: kButtonContainerColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //       )
//                           //     ],
//                           //   ),
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.02,
//                           // ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.start,
//                           //   children: [
//                           //     Text(
//                           //       'รีวิวทั้งหมด',
//                           //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           //     ),
//                           //   ],
//                           // ),
//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Container(
//                           //   padding: EdgeInsets.all(8.0),
//                           //   width: size.width * 0.95,
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white,
//                           //     borderRadius: BorderRadius.all(
//                           //       Radius.circular(8.0),
//                           //     ),
//                           //     boxShadow: [
//                           //       BoxShadow(
//                           //         offset: Offset(0, 0),
//                           //         blurRadius: 2,
//                           //         spreadRadius: 2,
//                           //         color: Colors.black26,
//                           //       ),
//                           //     ],
//                           //   ),
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //     children: [
//                           //       Expanded(
//                           //           flex: 3,
//                           //           child: Container(
//                           //             height: size.height * 0.15,
//                           //             decoration: BoxDecoration(
//                           //               shape: BoxShape.circle,
//                           //               image: DecorationImage(image: AssetImage('assets/images/person_pic1.png'), fit: BoxFit.fill),
//                           //             ),
//                           //           )
//                           //           // Image.asset('assets/images/person_pic1.png',
//                           //           //     // width: 300,
//                           //           //     height: size.height * 0.15,
//                           //           //     fit: BoxFit.fill),
//                           //           ),
//                           //       Expanded(
//                           //         flex: 7,
//                           //         child: Column(
//                           //           mainAxisAlignment: MainAxisAlignment.start,
//                           //           crossAxisAlignment: CrossAxisAlignment.start,
//                           //           children: [
//                           //             RatingBar.builder(
//                           //               initialRating: 5,
//                           //               minRating: 1,
//                           //               direction: Axis.horizontal,
//                           //               allowHalfRating: true,
//                           //               itemCount: 5,
//                           //               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //               unratedColor: Colors.grey,
//                           //               itemSize: isPhone(context) ? 40 : 60,
//                           //               itemBuilder: (context, _) {
//                           //                 return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //               },
//                           //               onRatingUpdate: (rating) {
//                           //                 print(rating);
//                           //               },
//                           //             ),
//                           //             Text(
//                           //               '“ทำดีมากเลยครับ ช่างละเอียด พูดจาดีมากครับ”',
//                           //               style: TextStyle(fontSize: isPhone(context) ? 14.92 : 24),
//                           //             ),
//                           //             Text(
//                           //               'นาย วิริยะ มานะมานี',
//                           //               style: TextStyle(fontSize: isPhone(context) ? 9.95 : 19),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),

//                           // SizedBox(
//                           //   height: size.height * 0.01,
//                           // ),
//                           // Container(
//                           //   padding: EdgeInsets.all(8.0),
//                           //   width: size.width * 0.95,
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white,
//                           //     borderRadius: BorderRadius.all(
//                           //       Radius.circular(8.0),
//                           //     ),
//                           //     boxShadow: [
//                           //       BoxShadow(
//                           //         offset: Offset(0, 0),
//                           //         blurRadius: 2,
//                           //         spreadRadius: 2,
//                           //         color: Colors.black26,
//                           //       ),
//                           //     ],
//                           //   ),
//                           //   child: Row(
//                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //     children: [
//                           //       Expanded(
//                           //         flex: 3,
//                           //         child: Image.asset('assets/images/person_pic2.png',
//                           //             // width: 300,
//                           //             height: size.height * 0.15,
//                           //             fit: BoxFit.fill),
//                           //       ),
//                           //       Expanded(
//                           //         flex: 7,
//                           //         child: Column(
//                           //           mainAxisAlignment: MainAxisAlignment.start,
//                           //           crossAxisAlignment: CrossAxisAlignment.start,
//                           //           children: [
//                           //             RatingBar.builder(
//                           //               initialRating: 5,
//                           //               minRating: 1,
//                           //               direction: Axis.horizontal,
//                           //               allowHalfRating: true,
//                           //               itemCount: 5,
//                           //               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                           //               unratedColor: Colors.grey,
//                           //               itemSize: isPhone(context) ? 40 : 60,
//                           //               itemBuilder: (context, _) {
//                           //                 return Image.asset('assets/icons/mingcute_star-fill.png');
//                           //               },
//                           //               onRatingUpdate: (rating) {
//                           //                 print(rating);
//                           //               },
//                           //             ),
//                           //             Text(
//                           //               '“สุดยอดช่าง ละเอียดมาก”',
//                           //               style: TextStyle(fontSize: isPhone(context) ? 14.92 : 24),
//                           //             ),
//                           //             Text(
//                           //               'นาย เเมน คล้ายสุพรรณ',
//                           //               style: TextStyle(fontSize: isPhone(context) ? 9.95 : 19),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),

//                           // SizedBox(
//                           //   height: size.height * 0.02,
//                           // ),
//                           // Text(
//                           //   'ดูรายละเอียดเพิ่มเติม',
//                           //   style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
//                           // ),

//                           ////
//                           SizedBox(
//                             height: size.height * 0.08,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : SizedBox.shrink();
//           })),
//     );
//   }
// }
