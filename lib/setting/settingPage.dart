import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/login/services/loginController.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/setting/Contectpage.dart';
import 'package:paragon/setting/PrivacyPolicy.dart';
import 'package:paragon/setting/editProfilePage.dart';
import 'package:paragon/setting/pmHistoryPage.dart';
import 'package:paragon/setting/resetPassword.dart';
import 'package:paragon/setting/widgets/AlertDialogLogout.dart';
import 'package:paragon/setting/widgets/AlertDialogTel.dart';
import 'package:paragon/setting/widgets/ContainerSetting.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double score = 0;
  double initialRating = 0;
  User? user;
  launchURL() async {
    const url = 'https://www.engineering1986.com/';
    _launch(url);
  }

  launchCALL({required String phone}) async {
    //02-159-9477
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserProfile());
    setState(() {
      score = initialRating;
      //user = context.read<HomeController>().user;
    });
  }

  Future<void> getUserProfile() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
        score = user!.score_avg!;
        initialRating = user!.score_avg!;
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
            height: isPhone(context) ? size.height * 0.14 : size.height * 0.10,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/red_appBar_pic.png'), fit: BoxFit.fill),
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
                  'ตั้งค่า',
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
          child: user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isPhone(context) ? size.height * 0.01 : size.height * 0.04,
                    ),
                    user != null
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                user!.image != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(user!.image ?? ""),
                                        radius: isPhone(context) ? 40 : 70,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/user.png'),
                                        radius: isPhone(context) ? 40 : 70,
                                      ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                                        child: Text(
                                          'ชื่อ: ${user!.name}',
                                          style: TextStyle(fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                                        child: Text(
                                          'อีเมล: ${user!.email}',
                                          style: TextStyle(fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      if (user!.type == 'customer')
                                        SizedBox()
                                      else
                                        // Row(
                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                        //   children: [
                                        //     IgnorePointer(
                                        //       ignoring: true,
                                        //       child: RatingBar.builder(
                                        //         initialRating: initialRating,
                                        //         minRating: 1,
                                        //         direction: Axis.horizontal,
                                        //         allowHalfRating: true,
                                        //         itemCount: 5,
                                        //         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        //         itemSize: isPhone(context) ? 40 : 60,
                                        //         unratedColor: Colors.grey,
                                        //         itemBuilder: (context, _) {
                                        //           return Image.asset('assets/icons/mingcute_star-fill.png');
                                        //         },
                                        //         onRatingUpdate: (rating) {},
                                        //       ),
                                        //     )

                                        //     // Text(
                                        //     //   '${score}/5.0 คะเเนน',
                                        //     //   style: TextStyle(fontSize: 9),
                                        //     // )
                                        //   ],
                                        // ),
                                      user!.type == 'customer'
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                                              child: Text(
                                                // '${score}/5.0 คะเเนน',
                                                '${score.toStringAsFixed(3)}/5.0 คะเเนน',
                                                style: TextStyle(fontSize: isPhone(context) ? 12 : 22),
                                              ),
                                            )
                                      // Text(
                                      //   'อีเมล : somboon@gmail.com',
                                      //   style: TextStyle(fontSize: 16.63),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: isPhone(context) ? size.height * 0.03 : size.height * 0.06,
                    ),
                    Center(
                      child: ContainerSetting(
                        size: size,
                        leadingIcon: 'assets/icons/iconamoon_profile-bold.png',
                        title: 'แก้ไขโปรไฟล์',
                        trailingIcon: 'assets/icons/ion_chevron-back.png',
                        press: () async {
                          final go = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                          if (go == true) {
                            getUserProfile();
                          } else {
                            getUserProfile();
                          }
                        },
                      ),
                    ),
                    user!.type == 'customer'
                        ? SizedBox(
                            height: size.height * 0.02,
                          )
                        : SizedBox(
                            height: size.height * 0.02,
                          ),
                    user!.type == 'customer'
                        ? ContainerSetting(
                            size: size,
                            leadingIcon: 'assets/icons/KPI.png',
                            title: 'แจ้งซ่อม',
                            trailingIcon: 'assets/icons/ion_chevron-back.png',
                            press: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Reportrepair()));
                            },
                          )
                        : ContainerSetting(
                            size: size,
                            leadingIcon: 'assets/icons/KPI.png',
                            title: 'KPI',
                            trailingIcon: 'assets/icons/ion_chevron-back.png',
                            press: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => KpiPage()));
                            },
                          ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    user!.type == 'customer'
                        ? ContainerSetting(
                            size: size,
                            leadingIcon: 'assets/icons/Time.png',
                            title: 'ประวัติแจ้งซ่อม',
                            trailingIcon: 'assets/icons/ion_chevron-back.png',
                            press: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => RepairHistory()));
                            },
                          )
                        : ContainerSetting(
                            size: size,
                            leadingIcon: 'assets/icons/Time.png',
                            title: 'ประวัติPM',
                            trailingIcon: 'assets/icons/ion_chevron-back.png',
                            press: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PmHistoryPage()));
                            },
                          ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ContainerSetting(
                      size: size,
                      leadingIcon: 'assets/icons/carbon_password.png',
                      title: 'เปลี่ยนรหัสผ่าน',
                      trailingIcon: 'assets/icons/ion_chevron-back.png',
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                      },
                    ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                    // ContainerSetting(
                    //   size: size,
                    //   leadingIcon: 'assets/icons/material-symbols_help-outline.png',
                    //   title: 'เปลี่ยนภาษา',
                    //   trailingIcon: 'assets/icons/ion_chevron-back.png',
                    //   press: () async {
                    //     final resdata = await showDialog(
                    //       barrierDismissible: false,
                    //       context: context,
                    //       builder: (context) => AlertDialogLocale(
                    //         pressYes: () {
                    //           Navigator.pop(context, true);
                    //         },
                    //       ),
                    //     );
                    //   },
                    // ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ContainerSetting(
                      size: size,
                      leadingIcon: 'assets/icons/lock-1_48006.png',
                      title: 'นโยบายความเป็นส่วนตัว',
                      trailingIcon: 'assets/icons/ion_chevron-back.png',
                      press: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ContainerSetting(
                      size: size,
                      leadingIcon: 'assets/icons/ion_call-outline.png',
                      title: 'ติดต่อ',
                      trailingIcon: 'assets/icons/ion_chevron-back.png',
                      press: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Contectpage(),
                            ));
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    // ContainerSetting(
                    //   size: size,
                    //   leadingIcon: 'assets/icons/XIcon.png',
                    //   title: context.locale == Locale('th') ? 'ลบบัญชี' : 'Delete Account',
                    //   trailingIcon: 'assets/icons/ion_chevron-back.png',
                    //   press: () async {
                    //     final delete = await showDialog(
                    //       barrierDismissible: false,
                    //       context: context,
                    //       builder: (context) => AlertDialogDelete(
                    //         pressYes: () {
                    //           Navigator.pop(context, true);
                    //         },
                    //       ),
                    //     );

                    //     if (delete == true) {
                    //       if (!mounted) return;
                    //       LoadingDialog.open(context);
                    //       try {
                    //         await SettingApi.deletAccount(user!.id);
                    //         if (!mounted) return;
                    //         LoadingDialog.close(context);
                    //         await context.read<LoginController>().clearToken();
                    //         if (!mounted) return;
                    //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //           builder: (context) {
                    //             return LoginPage();
                    //           },
                    //         ), (route) => false);
                    //       } on Exception catch (e) {
                    //         if (!mounted) return;
                    //         LoadingDialog.close(context);
                    //         if (!mounted) return;
                    //         showDialog(
                    //           context: context,
                    //           builder: (context) => AlertDialogYes(
                    //             title: 'แจ้งเตือน',
                    //             description: e.getMessage,
                    //             pressYes: () {
                    //               Navigator.pop(context, true);
                    //             },
                    //           ),
                    //         );
                    //       }
                    //     }
                    //   },
                    // ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                    // ContainerSetting(
                    //   size: size,
                    //   leadingIcon: 'assets/icons/icon_help.png',
                    //   title: 'ภาษา',
                    //   trailingIcon: 'assets/icons/icon_back.png',
                    //   press: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
                    //   },
                    // ),
                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),
                    ContainerSetting(
                      size: size,
                      leadingIcon: 'assets/icons/ic_outline-logout.png',
                      title: 'ออกจากระบบ',
                      trailingIcon: 'assets/icons/ion_chevron-back.png',
                      press: () async {
                        final ok = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialogLogout(
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
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                  ],
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
