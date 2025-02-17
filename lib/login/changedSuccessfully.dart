import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';

class ChangedSuccessfully extends StatefulWidget {
  const ChangedSuccessfully({super.key});

  @override
  State<ChangedSuccessfully> createState() => _ChangedSuccessfullyState();
}

class _ChangedSuccessfullyState extends State<ChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
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
                  height: size.height * 0.10,
                ),
                Center(
                  child: Image.asset(
                    "assets/icons/circle_success.png",
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'เปลี่ยนรหัสผ่านสำเร็จ',
                      style: TextStyle(fontSize: isPhone(context) ?25 :30, fontWeight: FontWeight.bold, color: kTextTitleColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'รหัสผ่านของคุณได้รับการเปลี่ยนเรียบร้อยเเล้ว',
                      style: TextStyle(fontSize: isPhone(context) ?15:24, fontWeight: FontWeight.bold, color: kTextSecondaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                ButtonOnClick(
                  size: size,
                  press: () {
                    Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  },
                  buttonName: 'กลับไปที่หน้าล็อกอิน',
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
