import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/login/services/loginApi.dart';
import 'package:paragon/models/customer.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? dropdownValue;
  final GlobalKey<FormState> regisFormKey = GlobalKey<FormState>();
  final TextEditingController user_id = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController tel = TextEditingController();
  final TextEditingController line_id = TextEditingController();
  TextEditingController dateController = TextEditingController();

  ///ส่วนของ customer
  final TextEditingController company_name = TextEditingController();
  final TextEditingController company_address = TextEditingController();
  final TextEditingController company_email = TextEditingController();
  final TextEditingController company_tax = TextEditingController();
  final TextEditingController company_tel = TextEditingController();

  ///
  DateTime selectedDate = DateTime.now();
  DateTime? newDateTime;
  XFile? image;
  ImagePicker picker = ImagePicker();
  List<Customer> customer = [];
  Customer? dropdownCustomer;

  Future<void> openDialogImage() async {
    final result = await showModalActionSheet<String>(
      context: context,
      title: 'เลือกรูปภาพ',
      cancelLabel: 'ยกเลิก',
      actions: [
        SheetAction<String>(label: 'ถ่ายรูป', key: 'camera'),
        SheetAction<String>(label: 'เลือกจากอัลบั้ม', key: 'gallery'),
      ],
      //style: ;
    );

    if (result != null) {
      if (result == 'camera') {
        final img = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          image = img;
        });
      }

      if (result == 'gallery') {
        final img = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          image = img;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context, Size size) async {
    if (Platform.isIOS) {
      final DateTime? pickedDate = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: size.height * 0.45,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                      child: GestureDetector(
                        onTap: () {
                          if (newDateTime != null) {
                            Navigator.pop(context, newDateTime);
                          } else {
                            Navigator.pop(context, null);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 250, 245, 239),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'เลือกวันที่',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: kTextSecondaryColor,
                                fontSize: isPhone(context) ? 18 : 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: size.height * 0.35,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime _newDateTime) {
                      setState(() {
                        newDateTime = _newDateTime;
                      });
                      print(newDateTime);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          dateController.text = formattedDate.toString(); // Update the text field
        });
      }
    } else if (Platform.isAndroid) {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kNaviSelectColor, // Header background color
              colorScheme:
                  ColorScheme.light(primary: kNaviSelectColor, background: kNaviSelectColor), // Day in the month color
              dialogBackgroundColor: kNaviSelectColor,
              //buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text color
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          dateController.text = formattedDate.toString(); // Update the text field
        });
      }
    }
  }

  Future<void> getCustomer() async {
    LoadingDialog.open(context);
    try {
      final _customer = await LoginApi.getCustomer();
      if (_customer != null) {
        setState(() {
          customer = _customer;
          dropdownCustomer = _customer[0];
        });
      } else {}

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
  void initState() {
    super.initState();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    dateController.text = formattedDate.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCustomer());
  }

  @override
  void dispose() async {
    dateController.dispose();
    super.dispose();
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
                Center(
                  child: Text(
                    'ลงทะเบียนเข้าใช้งาน',
                    style: TextStyle(
                        color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: isPhone(context) ? size.height * 0.05 : size.height * 0.07,
                  width: isPhone(context) ? size.width * 0.12 : size.width * 0.14,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Form(
              key: regisFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Stack(
                    children: [
                      image != null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: isPhone(context) ? 75.0 : 95,
                              backgroundImage: FileImage(File(image!.path)),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: isPhone(context) ? 75.0 : 95,
                              backgroundImage: AssetImage('assets/images/user.png'),
                            ),
                      Positioned(
                        right: image != null ? size.width * 0.02 : size.width * 0.0001,
                        bottom: image != null ? size.height * 0.02 : size.width * 0.01,
                        child: GestureDetector(
                          onTap: () => openDialogImage(),
                          child: Image.asset(
                            'assets/icons/solar_camera-minimalistic-bold.png',
                            scale: isPhone(context) ? 15 : 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ข้อมูลของลูกค้า',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อบริษัท',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: company_name,
                    hintText: 'ชื่อบริษัท',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกชื่อลูกค้า';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'เบอร์ลูกค้า',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: company_tel,
                    hintText: 'เบอร์ลูกค้า',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกชื่อลูกค้า';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'เลขประจำตัวผู้เสียภาษี',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: company_tax,
                    hintText: 'เลขประจำตัวผู้เสียภาษี',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกเลขประจำตัวผู้เสียภาษี';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'อีเมลลูกค้า',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: company_email,
                    hintText: 'อีเมลลูกค้า',
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกอีเมลลูกค้า';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ที่อยู่ลูกค้า',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: company_address,
                    hintText: 'ที่อยู่ลูกค้า',
                    maxline: 3,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกที่อยู่ลูกค้า';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Divider(
                    thickness: 2,
                    color: kTextSecondaryColor,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       context.locale == Locale('th') ? 'รหัสลูกค้า' : 'Customer ID',
                  //       style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // customer.isNotEmpty
                  //     ? Card(
                  //         elevation: 5,
                  //         child: DropdownButtonHideUnderline(
                  //           child: DropdownButton2<Customer>(
                  //             isExpanded: true,
                  //             hint: Text(
                  //               'Select Item',
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Theme.of(context).hintColor,
                  //               ),
                  //             ),
                  //             items: customer
                  //                 .map((Customer item) => DropdownMenuItem<Customer>(
                  //                       value: item,
                  //                       child: Text(
                  //                         item.name!,
                  //                         style: TextStyle(
                  //                           fontSize: isPhone(context) ? 20 : 30,
                  //                         ),
                  //                       ),
                  //                     ))
                  //                 .toList(),
                  //             value: dropdownCustomer,
                  //             onChanged: (Customer? value) {
                  //               setState(() {
                  //                 dropdownCustomer = value;
                  //               });
                  //             },
                  //             buttonStyleData: ButtonStyleData(
                  //               padding: EdgeInsets.symmetric(horizontal: 16),
                  //               height: size.height * 0.08,
                  //               //width: 200,
                  //             ),
                  //             menuItemStyleData: MenuItemStyleData(
                  //               height: size.height * 0.08,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อผู้ใช้',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: user_id,
                    hintText: 'ชื่อผู้ใช้',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกชื่อผู้ใช้';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'รหัสผ่าน',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: password,
                      hintText: 'รหัสผ่าน',
                      isPassword: true,
                      validator: (val) {
                        final regExp = RegExp(
                          r'^(?=.*\d)(?=.*[a-zA-Z]).{0,}$',
                        );
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกพาสเวิร์ด';
                        }
                        // if (val.length < 2 || val.length > 20) {
                        //   return 'พาสเวิร์ต้องมีความยาว 8 อักษรขึ้นไป';
                        // }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อ-นามสกุล',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: name,
                    hintText: 'ชื่อ-นามสกุล',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกชื่อ-นามสกุล';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'อีเมล',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: email,
                    hintText: 'อีเมล',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกอีเมล';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'เบอร์โทรศัพท์',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: tel,
                    hintText: 'เบอร์โทรศัพท์',
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกเบอร์โทรศัพท์';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'วันที่เข้าทำงาน',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 18 : 25),
                      decoration: InputDecoration(
                        hintText: 'วันที่เข้าทำงาน',
                        hintStyle: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 15 : 25),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          size: isPhone(context) ? 25 : 40,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        fillColor: kNaviPrimaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      onTap: () {
                        _selectDate(context, size);
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ไลน์ไอดี',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: isPhone(context) ? 18 : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                    controller: line_id,
                    hintText: 'ไลน์ไอดี',
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'กรุณากรอกอีเมล';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  ButtonOnClick(
                    size: size,
                    buttonName: 'บันทึก',
                    press: () async {
                      if (regisFormKey.currentState!.validate()) {
                        try {
                          LoadingDialog.open(context);

                          final _regis = await LoginApi.register(
                              file: image,
                              user_id: user_id.text,
                              password: password.text,
                              name: name.text,
                              tel: tel.text,
                              email: email.text,
                              register_date: dateController.text,
                              customer_id: dropdownCustomer!.id,
                              company_name: company_name.text,
                              company_tax: company_tax.text,
                              company_address: company_address.text,
                              company_email: company_email.text,
                              company_tel: company_tel.text);
                          if (_regis != null) {
                            if (!mounted) return;
                            LoadingDialog.close(context);
                            final _ok = await showDialog(
                              context: context,
                              builder: (context) => AlertDialogYes(
                                title: 'สำเร็จ',
                                description: 'สมัครสามาชิกสำเร็จแล้ว',
                                pressYes: () {
                                  Navigator.pop(context, true);
                                },
                              ),
                            );
                            if (_ok == true) {
                              Navigator.pop(context, true);
                            }
                          } else {
                            LoadingDialog.close(context);
                          }
                        } on Exception catch (e) {
                          if (!mounted) return;
                          LoadingDialog.close(context);
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
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
