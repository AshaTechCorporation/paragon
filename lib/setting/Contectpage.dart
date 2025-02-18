import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/models/config.dart';
import 'package:paragon/setting/service/settingApi.dart';
import 'package:paragon/setting/widgets/ContainerSetting.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Contectpage extends StatefulWidget {
  const Contectpage({super.key});

  @override
  State<Contectpage> createState() => _ContectpageState();
}

class _ContectpageState extends State<Contectpage> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              isPhone(context) ? size.height * 0.14 : size.height * 0.10),
          child: Container(
            height: isPhone(context) ? size.height * 0.14 : size.height * 0.10,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('$part_image'),
                  fit: BoxFit.fill),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.015,
                      horizontal: size.width * 0.01),
                  child: BackButtonOnClick(
                    size: size,
                    press: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                Text(
                  'ติดต่อ',
                  style: TextStyle(
                      color: kTextHeadColor,
                      fontSize: isPhone(context) ? 24 : 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height:
                      isPhone(context) ? size.height * 0.05 : size.height * 0.07,
                  width: isPhone(context) ? size.width * 0.12 : size.width * 0.14,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: config != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: isPhone(context)
                            ? size.height * 0.01
                            : size.height * 0.04,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ContainerSetting(
                        size: size,
                        leadingIcon: 'assets/icons/ion_call-outline.png',
                        title: '${config!.tel}',
                        trailingIcon: 'assets/icons/ion_chevron-back.png',
                        press: () {
                          launchCALL(phone: config!.tel ?? "");
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ContainerSetting(
                        size: size,
                        leadingIcon: 'assets/icons/email.jpg',
                        title: 'EMAIL',
                        trailingIcon: 'assets/icons/ion_chevron-back.png',
                        press: () {
                          launchEMAIL(config!.email ?? "");
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ContainerSetting(
                        size: size,
                        leadingIcon: 'assets/icons/facebook.ico',
                        title: 'FACEBOOK',
                        trailingIcon: 'assets/icons/ion_chevron-back.png',
                        press: () {
                          launchFacebook(config!.facebook ?? "");
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ContainerSetting(
                        size: size,
                        leadingIcon: 'assets/icons/line_logo_icon.ico',
                        title: 'LINE',
                        trailingIcon: 'assets/icons/ion_chevron-back.png',
                        press: () {
                          launchLine(config!.line ?? "");
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  launchCALL({required String phone}) async {
    String phonenumber = "tel:${phone}";
    _launch(phonenumber);
  }

  _launch(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEMAIL(String linkemail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: linkemail,
      // queryParameters: {'subject': 'Testing URL_LAUNCHER | DEMO', 'body': 'MESSAGE'},
    );
    final email = "mailto:${emailLaunchUri.path}";
    _launch(email);
  }

  void launchFacebook(String linkfacebook) async {
    final url = Uri.parse("${linkfacebook}");
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  void launchLine(String lineurl) async {
    final url = Uri.parse("${lineurl}");
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
