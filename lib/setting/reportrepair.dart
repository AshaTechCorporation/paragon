// import 'dart:developer';
// import 'dart:io';

// import 'package:adaptive_dialog/adaptive_dialog.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class Reportrepair extends StatefulWidget {
//   const Reportrepair({super.key});

//   @override
//   State<Reportrepair> createState() => _ReportrepairState();
// }

// class _ReportrepairState extends State<Reportrepair> {
//   final GlobalKey<FormState> _repairFormKey = GlobalKey<FormState>();
//   final TextEditingController model = TextEditingController();
//   final TextEditingController location = TextEditingController();
//   final TextEditingController symptom = TextEditingController();
//   final TextEditingController equipment = TextEditingController();
//   final TextEditingController contact = TextEditingController();
//   final TextEditingController name = TextEditingController();
//   final TextEditingController lineId = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController remark = TextEditingController();
//   User? user;
//   XFile? image;
//   XFile? image1;
//   XFile? image2;
//   ImagePicker picker = ImagePicker();

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

//   Future openDialogImage() async {
//     final result = await showModalActionSheet<String>(
//       context: context,
//       title: 'เลือกรูปภาพ',
//       cancelLabel: 'ยกเลิก',
//       actions: [
//         SheetAction<String>(label: 'ถ่ายรูป', key: 'camera'),
//         SheetAction<String>(label: 'เลือกจากอัลบั้ม', key: 'gallery'),
//       ],
//     );

//     if (result != null) {
//       if (result == 'camera') {
//         final img = await picker.pickImage(source: ImageSource.camera);
//         return img;
//       }

//       if (result == 'gallery') {
//         final img = await picker.pickImage(source: ImageSource.gallery);
//         return img;
//       }
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
//               image: DecorationImage(image: AssetImage('assets/images/appBar_pic.png'), fit: BoxFit.fill),
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
//                   'แจ้งซ่อม',
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
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
//             child: Form(
//               key: _repairFormKey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height * 0.04,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'รุ่นเครื่อง /Model',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: model,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกรุ่น';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ตำแหน่ง/สถานที่ตั้ง/อาคาร',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: location,
//                     hintText: '',
//                     maxline: 3,
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกที่อยู่';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'อุปกรณ์ที่ชำรุด /Equipmant Name',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: equipment,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกอุปกรณ์';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'อาการ/สาเหตุเบื้องต้น',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: symptom,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกสาเหตุ';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ข้อมูลผู้ประสานงานหน้างาน /Contact Person',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: contact,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกข้อมูลผู้ประสานงาน';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ชื่อ / Name',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: name,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกชื่อ';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Line ID',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: lineId,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     // validator: (val) {
//                     //   if (val == null || val.isEmpty) {
//                     //     return 'กรุณากรอก';
//                     //   }
//                     //   return null;
//                     // },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'เบอร์ติดต่อ / Telephone No',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   AppTextForm(
//                     controller: phone,
//                     hintText: '',
//                     //readOnly: readOnly,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'กรุณากรอกเบอร์ติดต่อ';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   // SizedBox(
//                   //   height: size.height * 0.02,
//                   // ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.start,
//                   //   children: [
//                   //     Text(
//                   //       'หมายเหตุ อุปกรณ์ที่ควรมีไว้ใช้งานเบื้องต้น',
//                   //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                   //     ),
//                   //   ],
//                   // ),
//                   // SizedBox(
//                   //   height: size.height * 0.01,
//                   // ),
//                   // AppTextForm(
//                   //   controller: remark,
//                   //   hintText: '',
//                   //   maxline: 6,
//                   //   //readOnly: readOnly,1`
//                   //   // validator: (val) {
//                   //   //   if (val == null || val.isEmpty) {
//                   //   //     return 'กรุณากรอก';
//                   //   //   }
//                   //   //   return null;
//                   //   // },
//                   // ),
//                   SizedBox(
//                     height: size.height * 0.02,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'รูปภาพ',
//                         style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 24, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       image != null
//                           ? GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image = img;
//                                   });
//                                 }
//                               },
//                               onLongPress: () async {
//                                 final ok1 = await showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialogYesNo(
//                                     title: 'แจ้งเตือน',
//                                     description: 'ต้องการลบรูปภาพหรือไม่',
//                                     pressYes: () {
//                                       Navigator.pop(context, true);
//                                     },
//                                     pressNo: () {
//                                       Navigator.pop(context, false);
//                                     },
//                                   ),
//                                 );
//                                 if (ok1 == true) {
//                                   setState(() {
//                                     image = null;
//                                   });
//                                 }
//                               },
//                               child: SizedBox(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Image(
//                                   image: FileImage(File(image!.path)),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image = img;
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/icons/line_icons_plus.png',
//                                       height: size.height * 0.04,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     SizedBox(
//                                       height: size.height * 0.01,
//                                     ),
//                                     Text('รูปภาพ',
//                                         style: TextStyle(
//                                           color: kNaviUnSelectColor,
//                                           fontSize: isPhone(context) ? 15.93 : 20,
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),

//                       ///////////////////
//                       ///
//                       image1 != null
//                           ? GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image1 = img;
//                                   });
//                                 }
//                               },
//                               onLongPress: () async {
//                                 final ok1 = await showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialogYesNo(
//                                     title: 'แจ้งเตือน',
//                                     description: 'ต้องการลบรูปภาพหรือไม่',
//                                     pressYes: () {
//                                       Navigator.pop(context, true);
//                                     },
//                                     pressNo: () {
//                                       Navigator.pop(context, false);
//                                     },
//                                   ),
//                                 );
//                                 if (ok1 == true) {
//                                   setState(() {
//                                     image1 = null;
//                                   });
//                                 }
//                               },
//                               child: SizedBox(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Image(
//                                   image: FileImage(File(image1!.path)),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image1 = img;
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/icons/line_icons_plus.png',
//                                       height: size.height * 0.04,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     SizedBox(
//                                       height: size.height * 0.01,
//                                     ),
//                                     Text('รูปภาพ',
//                                         style: TextStyle(
//                                           color: kNaviUnSelectColor,
//                                           fontSize: isPhone(context) ? 15.93 : 20,
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       image2 != null
//                           ? GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image2 = img;
//                                   });
//                                 }
//                               },
//                               onLongPress: () async {
//                                 final ok1 = await showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialogYesNo(
//                                     title: 'แจ้งเตือน',
//                                     description: 'ต้องการลบรูปภาพหรือไม่',
//                                     pressYes: () {
//                                       Navigator.pop(context, true);
//                                     },
//                                     pressNo: () {
//                                       Navigator.pop(context, false);
//                                     },
//                                   ),
//                                 );
//                                 if (ok1 == true) {
//                                   setState(() {
//                                     image2 = null;
//                                   });
//                                 }
//                               },
//                               child: SizedBox(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Image(
//                                   image: FileImage(File(image2!.path)),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () async {
//                                 final img = await openDialogImage();
//                                 if (img != null) {
//                                   setState(() {
//                                     image2 = img;
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 height: size.height * 0.22,
//                                 width: size.width * 0.42,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/icons/line_icons_plus.png',
//                                       height: size.height * 0.04,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     SizedBox(
//                                       height: size.height * 0.01,
//                                     ),
//                                     Text('รูปภาพ',
//                                         style: TextStyle(
//                                           color: kNaviUnSelectColor,
//                                           fontSize: isPhone(context) ? 15.93 : 20,
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                       Container(
//                         height: size.height * 0.22,
//                         width: size.width * 0.42,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.05,
//                   ),
//                   ButtonOnClick(
//                     size: size,
//                     buttonName: context.locale == Locale('th') ? 'บันทึก' : 'Save',
//                     press: () async {
//                       if (_repairFormKey.currentState!.validate()) {
//                         try {
//                           LoadingDialog.open(context);
//                           if (image != null || image1 != null || image2 != null) {
//                             String? _image1;
//                             String? _image2;
//                             String? _image3;
//                             if (image != null) {
//                               _image1 = await UoloadService.uploadImage(image!);
//                             }
//                             if (image1 != null) {
//                               _image2 = await UoloadService.uploadImage(image1!);
//                             }
//                             if (image2 != null) {
//                               _image3 = await UoloadService.uploadImage(image2!);
//                             }

//                             final _repair = await JobApi.reportRepair(
//                                 customer_id: user!.customer_id!,
//                                 date: DateTime.now().toString(),
//                                 model: model.text,
//                                 location: location.text,
//                                 equipment_name: equipment.text,
//                                 casey: symptom.text,
//                                 contact_person: contact.text,
//                                 name: name.text,
//                                 line_id: lineId.text,
//                                 tel: phone.text,
//                                 image: _image1!,
//                                 image_second: _image2!,
//                                 image_third: _image3!);
//                             if (_repair != null) {
//                               LoadingDialog.close(context);
//                               final _ok = await showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (context) => AlertDialogYes(
//                                   title: 'แจ้งเตือน',
//                                   description: 'ดำเนินการแจ้งซ่อมสำเร็จ',
//                                   pressYes: () {
//                                     Navigator.pop(context, true);
//                                   },
//                                 ),
//                               );
//                               if (_ok == true) {
//                                 Navigator.pop(context);
//                               }
//                             } else {
//                               LoadingDialog.close(context);
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialogYes(
//                                   title: 'แจ้งเตือน',
//                                   description: 'เกิดข้อผิดพลาดระหว่างบันทึกแจ้งซ่อม',
//                                   pressYes: () {
//                                     Navigator.pop(context, true);
//                                   },
//                                 ),
//                               );
//                             }
//                           } else {
//                             final _repair = await JobApi.reportRepair(
//                                 customer_id: user!.customer_id!,
//                                 date: DateTime.now().toString(),
//                                 model: model.text,
//                                 location: location.text,
//                                 equipment_name: equipment.text,
//                                 casey: symptom.text,
//                                 contact_person: contact.text,
//                                 name: name.text,
//                                 line_id: lineId.text,
//                                 tel: phone.text,
//                                 image: '',
//                                 image_second: '',
//                                 image_third: '');
//                             if (_repair != null) {
//                               LoadingDialog.close(context);
//                               final _ok = await showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (context) => AlertDialogYes(
//                                   title: 'แจ้งเตือน',
//                                   description: 'ดำเนินการสำเร็จ',
//                                   pressYes: () {
//                                     Navigator.pop(context, true);
//                                   },
//                                 ),
//                               );
//                               if (_ok == true) {
//                                 Navigator.pop(context);
//                               }
//                             } else {
//                               LoadingDialog.close(context);
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => AlertDialogYes(
//                                   title: 'แจ้งเตือน',
//                                   description: 'เกิดข้อผิดพลาดระหว่างบันทึกแจ้งซ่อม',
//                                   pressYes: () {
//                                     Navigator.pop(context, true);
//                                   },
//                                 ),
//                               );
//                             }
//                           }
//                         } on Exception catch (e) {
//                           if (!mounted) return;
//                           LoadingDialog.close(context);
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialogYes(
//                               title: 'แจ้งเตือน',
//                               description: '${e.getMessage}',
//                               pressYes: () {
//                                 Navigator.pop(context, true);
//                               },
//                             ),
//                           );
//                         }
//                       }
//                     },
//                   ),
//                   SizedBox(
//                     height: size.height * 0.08,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
