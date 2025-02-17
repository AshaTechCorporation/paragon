import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/login/changePassword.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key, this.email});
  String? email;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

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
                  height: size.height * 0.08,
                ),
                Row(
                  children: [
                    Text(
                      'กรุณาเช็คอีเมลของคุณ',
                      style: TextStyle(fontSize: isPhone(context) ? 24 : 34, fontWeight: FontWeight.bold, color: kTextTitleColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Text(
                  'เราได้ส่งรหัสผ่านไปที่อีเมล ${widget.email} โปรดตรวจสอบอีเมลของคูณ',
                  style: TextStyle(fontSize: isPhone(context) ? 15 : 25, fontWeight: FontWeight.bold, color: kTextSecondaryColor),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                /////////////////
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 30,
                    ),
                    child: PinCodeTextField(
                      appContext: context,
                      //backgroundColor: kFontDesColor,
                      pastedTextStyle: TextStyle(
                        color: kFontDesColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      //obscuringCharacter: '*',
                      enablePinAutofill: false,
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      //blinkWhenObscuring: true,
                      //animationType: AnimationType.fade,
                      validator: (v) {
                        // if (v!.length < 3) {
                        //   return "I'm from validator";
                        // } else {
                        //   return null;
                        // }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: size.height * 0.08,
                        fieldWidth: size.width * 0.14,
                        activeFillColor: kNaviPrimaryColor,
                        selectedFillColor: kNaviPrimaryColor,
                        activeColor: kNaviPrimaryColor,
                        inactiveFillColor: kNaviPrimaryColor,
                        inactiveColor: kFontDesColor,
                        selectedColor: kFontDesColor,
                        disabledColor: kFontDesColor,
                        activeBoxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            color: kFontDesColor,
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal,
                          )
                        ],
                        inActiveBoxShadow: [
                          BoxShadow(
                            offset: Offset(1, 1),
                            color: kFontDesColor,
                            blurRadius: 10,
                            blurStyle: BlurStyle.normal,
                          )
                        ],
                      ),
                      cursorColor: kFontDesColor,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          color: kFontDesColor,
                          blurRadius: 10,
                          blurStyle: BlurStyle.normal,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                ),

                ///
                SizedBox(
                  height: size.height * 0.04,
                ),
                ButtonOnClick(
                  size: size,
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                  },
                  buttonName: 'ยืนยันรหัสผ่าน',
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ส่งรหัสผ่านอีกครั้ง 00:20',
                      style: TextStyle(fontSize: isPhone(context) ? 16 : 25, color: kTextSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
