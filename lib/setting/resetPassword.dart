import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/login/services/loginApi.dart';
import 'package:paragon/login/services/loginController.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserProfile());
  }

  Future<void> getUserProfile() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
      });
      if (!mounted) return;
      LoadingDialog.close(context);
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
                  'เปลี่ยนรหัสผ่าน',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Form(
              key: resetFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'รหัสผ่านเดิม',
                        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: oldpassword,
                      hintText: 'ใส่รหัสผ่าน',
                      isPassword: true,
                      validator: (val) {
                        final regExp = RegExp(
                          r'^(?=.*\d)(?=.*[a-zA-Z]).{0,}$',
                        );
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกพาสเวิร์ด';
                        }
                        if (val.length < 2 || val.length > 20) {
                          return 'พาสเวิร์ต้องมีความยาว 8 อักษรขึ้นไป';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'รหัสผ่านใหม่',
                        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: newpassword,
                      hintText: 'ใส่รหัสผ่าน',
                      isPassword: true,
                      validator: (val) {
                        final regExp = RegExp(
                          r'^(?=.*\d)(?=.*[a-zA-Z]).{0,}$',
                        );
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกพาสเวิร์ด';
                        }
                        if (val.length < 2 || val.length > 20) {
                          return 'พาสเวิร์ต้องมีความยาว 8 อักษรขึ้นไป';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ยืนยันรหัสผ่านใหม่',
                        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: confirmpassword,
                      hintText: 'ใส่รหัสผ่าน',
                      isPassword: true,
                      validator: (val) {
                        final regExp = RegExp(
                          r'^(?=.*\d)(?=.*[a-zA-Z]).{0,}$',
                        );
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกพาสเวิร์ด';
                        }
                        if (val.length < 2 || val.length > 20) {
                          return 'พาสเวิร์ต้องมีความยาว 8 อักษรขึ้นไป';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  ButtonOnClick(
                    size: size,
                    press: () async {
                      //Navigator.of(context).pop();
                      if (resetFormKey.currentState!.validate()) {
                        try {
                          LoadingDialog.open(context);
                          final reset = await LoginApi.resetPassWord(user!.id, oldpassword.text, newpassword.text, confirmpassword.text);
                          if (!mounted) return;
                          LoadingDialog.close(context);
                          final ok = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialogYes(
                              title: 'ดำเนินการสำเร็จ',
                              description: 'รหัสผ่านของคุณถูกเปลี่ยนแล้ว',
                              pressYes: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          );
                          if (ok == true) {
                            if (!mounted) return;
                            context.read<LoginController>().clearToken().then((value) {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                            });
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
                    buttonName: 'บันทึก',
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
