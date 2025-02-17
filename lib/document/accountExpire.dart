import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';

class AccountExpire extends StatefulWidget {
  const AccountExpire({super.key});

  @override
  State<AccountExpire> createState() => _AccountExpireState();
}

class _AccountExpireState extends State<AccountExpire> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonOnClick(
                      size: size,
                      press: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      context.locale == Locale('th') ? 'เอกสาร PM' : 'Document',
                      style: TextStyle(
                        color: kTextHeadColor,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Image.asset('assets/icons/popup.png'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Account Expire',
                style: TextStyle(color: kTextHeadColor, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                ' Please contact admin',
                style: TextStyle(
                  color: kTextTitleColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: ButtonOnClick(
                  size: size,
                  press: () {
                    //Navigator.pop(context, true);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Contectpage(),
                    //     ));
                  },
                  buttonName: context.locale == Locale('th') ? 'ติดต่อเจ้าหน้าที่' : 'Contact staff',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
