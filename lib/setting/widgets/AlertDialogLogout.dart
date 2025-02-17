import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';

class AlertDialogLogout extends StatelessWidget {
  AlertDialogLogout({
    Key? key,
    required this.pressYes,
  }) : super(key: key);
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: kTextButtonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Container(
        height: size.height * 0.24, //รอปรับที่หน้าโทรศัพท์ อีกที
        width: size.width * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Image.asset(
                      'assets/icons/XIcon.png',
                      scale: 10,
                    )),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
                child: Text(
              'ออกจากระบบ',
              style: TextStyle(fontSize: 30, color: kIndigatorColor, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            ButtonOnClick(
              size: size,
              press: pressYes,
              buttonName: 'ยืนยันออกจากระบบ',
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogDelete extends StatelessWidget {
  AlertDialogDelete({
    Key? key,
    required this.pressYes,
  }) : super(key: key);
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: kTextButtonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Container(
        height: size.height * 0.24, //รอปรับที่หน้าโทรศัพท์ อีกที
        width: size.width * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Image.asset(
                      'assets/icons/XIcon.png',
                      scale: 10,
                    )),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
                child: Text(
              context.locale == Locale('th') ? 'ลบบัญชี' : 'Delete Account',
              style: TextStyle(fontSize: 30, color: kIndigatorColor, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            ButtonOnClick(
              size: size,
              press: pressYes,
              buttonName: context.locale == Locale('th') ? 'ยืนยันที่จะลบบัญชี' : 'Confirm delete account.',
            ),
          ],
        ),
      ),
    );
  }
}
