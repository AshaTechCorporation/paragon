import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xff1c1c1c);
const kContainer = Color(0xff1c1c1c);

const kFontTextColor = Color(0xffaaaaaa);
const kFontSecondTextColor = Color(0xff888888);
const kInputColor = Color(0xffaaaaaa);
const kIconColor = Color(0xffffffff);
const kHintextColor = Color(0xffaaaaaa);
const kLinkTextColor = Color(0xff8e815e);
const kSecondaryColor = Color.fromARGB(255, 81, 120, 136);
const kPrimaryColor = Color(0xFF01579B);
const kBorderColor = Color(0xFFF1EEEE);

const kTextTitleColor = Color(0xFF5C5C5C);
const kTextSecondaryColor = Color(0xFF7B7B7B);
const kTextButtonColor = Color.fromARGB(255, 255, 255, 255);
const kTextForgotPasswordColor = Color(0xFF5C5C5C);
const kButtoncolor = Color(0xFFFC7716);
const kBordercolor = Color(0xFFD8DADC);
const kNaviPrimaryColor = Color(0xffffffff);
const kNaviSelectColor = Color(0xffFC7716);
const kNaviUnSelectColor = Color(0xffC4C4C4);
const kIndigatorColor = Color(0xffFA5A0E);
const kUnUseIndigatorColor = Color(0xffDEDBDB);
const kFontDesColor = Color(0xff7B7B7B);
const kFontHiligthColor = Color(0xffFA5A0E);
const kTextHeadColor = Color(0xff000000);
const kTextDateColor = Color(0xffFA5A0E);
const kStatusSuccessColor = Color(0xffE8BC42);
const kStatusWaitColor = Color(0xff33C600);
const kStatusEndColor = Color(0xffFF0808);
const kButtonContainerColor = Color(0xffFA5A0E);
const kSecondaryHiligtColor = Color(0xffE8BC42);
const kDividerColor = Color(0xffD9D9D9);
const kDropDownColor = Color(0xffFC7716);
const kCalendarColor = Color.fromARGB(255, 240, 183, 143);

const double defaultPadding = 16.0;

// const String publicUrl = 'powertech-control-api.dev-asha.com';
// const String pubUrl = 'https://powertech-control-api.dev-asha.com';
const String publicUrl = 'power-pm-api.dev-asha.com:8443';
const String pubUrl = 'https://power-pm-api.dev-asha.com:8443';

bool isPhone(BuildContext context) => MediaQuery.of(context).size.shortestSide < 550;

SizedBox kDefaultHSpacing(BuildContext context) {
  final isPhone = MediaQuery.of(context).size.shortestSide < 550;
  return SizedBox(height: isPhone ? 8 : 18);
}