import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/login/changedSuccessfully.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
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
                        'เปลี่ยนรหัสผ่าน',
                        style: TextStyle(fontSize: isPhone(context) ?25:35, fontWeight: FontWeight.bold, color: kTextTitleColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        'ใส่รหัสผ่านที่คุณต้องการ',
                        style: TextStyle(fontSize: isPhone(context) ?15:25, fontWeight: FontWeight.bold, color: kTextSecondaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'รหัสผ่านใหม่',
                        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ?20:30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: password,
                      hintText: 'ใส่รหัสผ่าน',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'ยืนยันรหัสผ่าน',
                        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ?20:30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppTextForm(
                      controller: confirmpassword,
                      hintText: 'ยืนยันรหัสผ่าน',
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
                    height: size.height * 0.06,
                  ),
                  ButtonOnClick(
                    size: size,
                    press: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangedSuccessfully()));
                    },
                    buttonName: 'เปลี่ยนรหัสผ่าน',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
