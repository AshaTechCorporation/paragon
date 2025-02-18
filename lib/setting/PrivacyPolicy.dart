import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/models/config.dart';
import 'package:paragon/setting/service/settingApi.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Config? config;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => privacy());
  }

  Future<void> privacy() async {
    LoadingDialog.open(context);
    try {
      final getpervacy = await SettingApi.getPrivacy(1);
      setState(() {
        config = getpervacy;
      });
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

  String cleanHtml(String html) {
  return html
      .replaceAll(RegExp(r'<font[^>]*>'), '')  // ลบ <font> และคุณสมบัติข้างใน
      .replaceAll(RegExp(r'</font>'), '')       // ลบ </font>
      .replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), ''); // ลบ <style>
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              isPhone(context) ? size.height * 0.14 : size.height * 0.10),
          child: Container(
            height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/red_appBar_pic.png'),
                  fit: BoxFit.fill),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.025,
                      horizontal: size.width * 0.01),
                  child: BackButtonOnClick(
                    size: size,
                    press: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                Text(
                  'นโยบายความเป็นส่วนตัว',
                  style: TextStyle(
                      color: kTextHeadColor,
                      fontSize: isPhone(context) ? 22 : 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: isPhone(context)
                      ? size.height * 0.05
                      : size.height * 0.07,
                  width:
                      isPhone(context) ? size.width * 0.12 : size.width * 0.14,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: config != null
                ? Html(
                    data: cleanHtml(config!.condition ?? ""),
                    style: {
                      "body": Style(
                        fontFamily: 'Arial', // ใช้ฟอนต์มาตรฐานเพื่อลดปัญหา
                        fontSize: FontSize(16),
                      ),
                    },
                    
                  )
                : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
