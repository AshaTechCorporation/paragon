import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/login/services/loginApi.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Form(
        key: forgotFormKey,
        child: Stack(
          children: [
            BackgroundImage(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        BackButtonOnClick(
                          size: size,
                          press: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    Row(
                      children: [
                        Text(
                          'ลืมรหัสผ่าน',
                          style: TextStyle(
                              fontSize: isPhone(context) ? 25 : 35,
                              fontWeight: FontWeight.bold,
                              color: kTextTitleColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'ระบบจะส่งรหัสผ่านเพื่อยืนยันไปที่อีเมลของคุณ',
                      style: TextStyle(
                          fontSize: isPhone(context) ? 16 : 25,
                          fontWeight: FontWeight.bold,
                          color: kTextSecondaryColor),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'อีเมล',
                          style: TextStyle(
                              color: kTextSecondaryColor,
                              fontSize: isPhone(context) ? 24 : 34,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    AppTextForm(
                      controller: email,
                      hintText: 'กรุณาใส่อีเมลของคุณ',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    ButtonOnClick(
                      size: size,
                      press: () async {
                        if (forgotFormKey.currentState!.validate()) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OtpPage(
                          //               email: email.text,
                          //             )));
                          try {
                            LoadingDialog.open(context);
                            final _forgot =
                                await LoginApi.forgotPassword(email.text);
                            if (_forgot == true) {
                              if (!mounted) return;
                              LoadingDialog.close(context);
                              final ok = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialogYes(
                                  title: 'ส่งรหัสผ่านสำเร็จ',
                                  description:
                                      'รหัสผ่านของคุณถูกส่งไปที่ ${email.text} โปรดตรวจสอบอีเมลของคุณ',
                                  pressYes: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              );
                              if (ok == true) {
                                if (!mounted) return;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              }
                              //Navigator.pop(context, true);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => OtpPage(
                              //               email: email.text,
                              //             )));
                            } else {
                              if (!mounted) return;
                              LoadingDialog.close(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialogYes(
                                  title: 'แจ้งเตือน',
                                  description: '${_forgot}',
                                  pressYes: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              );
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
                      buttonName: 'ยืนยัน',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
