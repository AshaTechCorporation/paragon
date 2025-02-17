import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/firstPage.dart';
import 'package:paragon/login/services/loginController.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  FirebaseMessaging? messaging;
  List<String> list = [
    'th',
    'en',
  ];
  String? dropdownValue;

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        androidInfo = await deviceInfo.androidInfo;
        // inspect(androidInfo!.id);
      } else if (Platform.isIOS) {
        iosInfo = await deviceInfo.iosInfo;
        // inspect(iosInfo!.utsname.sysname);
      }
    } on PlatformException {
      // inspect('Error: Failed to get platform version.');
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    setState(() {
      dropdownValue = list.first;
      //messaging = FirebaseMessaging.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Consumer<LoginController>(builder: (context, controller, child) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: isPhone(context) ? 1 : 1.5,
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  alignment: AlignmentDirectional.centerEnd,
                                  //isDense: true,
                                  //isExpanded: true,
                                  //icon: Icon(Icons.keyboard_arrow_down, color: kNaviPrimaryColor,),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: kNaviPrimaryColor,
                                    size: 30,
                                  ),
                                  dropdownColor: kDropDownColor,
                                  elevation: 16,
                                  style: TextStyle(color: kNaviPrimaryColor),
                                  underline: Container(
                                    height: 2,
                                    //color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value;
                                      context.setLocale(Locale(dropdownValue!));
                                    });
                                  },
                                  items: list.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          value == 'th'
                                              ? Text('ไทย',
                                                  style: TextStyle(
                                                    color: kNaviPrimaryColor,
                                                    fontSize: isPhone(context) ? 20.57 : 25,
                                                  ),
                                                  textAlign: TextAlign.right)
                                              : Text('English',
                                                  style: TextStyle(
                                                    color: kNaviPrimaryColor,
                                                    fontSize: isPhone(context) ? 20.57 : 25,
                                                  ),
                                                  textAlign: TextAlign.right),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         'English',
                        //         style: TextStyle(color: kNaviPrimaryColor, fontSize: 20.57),
                        //       ),
                        //       Icon(
                        //         Icons.keyboard_arrow_down,
                        //         color: kNaviPrimaryColor,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Image.asset(
                          "assets/images/123640.jpg",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(color: kTextTitleColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'อีเมล',
                                    style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
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
                                    'รหัสผ่าน',
                                    style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
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
                                height: size.height * 0.04,
                              ),
                              ButtonOnClick(
                                size: size,
                                press: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    try {
                                      LoadingDialog.open(context);
                                      if (androidInfo != null) {
                                        // final notify_token = await messaging!.getToken();
                                        await controller.signIn(email: email.text, password: password.text, deviceId: androidInfo!.id, notify_token: 'notify_token');
                                        //await controller.signIn(tel: username.text, password: password.text, deviceId: androidInfo!.id);
                                      } else if (iosInfo != null) {
                                        //await controller.signIn(tel: username.text, password: password.text, deviceId: iosInfo!.utsname.machine!);
                                        // final notify_token = await messaging?.getToken();
                                        await controller.signIn(email: email.text, password: password.text, deviceId: iosInfo!.utsname.machine, notify_token: 'notify_token');
                                      }

                                      if (!mounted) return;
                                      LoadingDialog.close(context);
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
                                      // if (controller.user!.type == 'customer') {
                                      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CusFirstPage()), (route) => false);
                                      // } else {
                                      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
                                      // }
                                    } on Exception catch (e) {
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
                                buttonName: 'เข้าสู่ระบบ',
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                                    },
                                    child: Text(
                                      'ลงทะเบียนเข้าใช้งาน',
                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                    },
                                    child: Text(
                                      'ลืมรหัสผ่าน',
                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
      ],
    );
  }
}
