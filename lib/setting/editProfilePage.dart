import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/login/services/loginController.dart';
import 'package:paragon/setting/service/settingApi.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/BackgroundImage.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  XFile? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserProfile();
    });
  }

  @override
  void dispose() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   getUserProfile();
    // });
    super.dispose();
  }

  Future<void> getUserProfile() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        firstname.text = context.read<HomeController>().user?.name ?? '';
        phone.text = context.read<HomeController>().user?.tel ?? '';
        email.text = context.read<HomeController>().user?.email ?? '';
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

  Future<void> openDialogImage() async {
    final result = await showModalActionSheet<String>(
      context: context,
      title: 'เลือกรูปภาพ',
      cancelLabel: 'ยกเลิก',
      actions: [
        SheetAction<String>(label: 'ถ่ายรูป', key: 'camera'),
        SheetAction<String>(label: 'เลือกจากอัลบั้ม', key: 'gallery'),
      ],
      //style: ;
    );

    if (result != null) {
      if (result == 'camera') {
        final img = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          image = img;
        });
      }

      if (result == 'gallery') {
        final img = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          image = img;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, homecontroller, child) {
      final user = homecontroller.user;
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(isPhone(context) ? size.height * 0.14 : size.height * 0.10),
            child: Container(
              height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('$part_image'), fit: BoxFit.fill),
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
                    'แก้ไขโปรไฟล์',
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
          //backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              BackgroundImage(),
              SingleChildScrollView(
                child: Form(
                  key: editFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Stack(
                        children: [
                          user!.image != null && image == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: isPhone(context) ? 75.0 : 95,
                                  backgroundImage: NetworkImage('${user.image!}'),
                                )
                              : image != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: isPhone(context) ? 75.0 : 95,
                                      backgroundImage: FileImage(File(image!.path)),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: isPhone(context) ? 75.0 : 95,
                                      backgroundImage: AssetImage('assets/images/user.png'),
                                    ),
                          Positioned(
                            right: user.image != null
                                ? size.width * 0.001
                                : image != null
                                    ? size.width * 0.01
                                    : size.width * 0.08,
                            bottom: user.image != null
                                ? size.width * 0.001
                                : image != null
                                    ? size.height * 0.02
                                    : size.width * 0.08,
                            child: GestureDetector(
                              onTap: () => openDialogImage(),
                              child: Image.asset(
                                'assets/icons/solar_camera-minimalistic-bold.png',
                                scale: isPhone(context) ? 16 : 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อ',
                                  style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            AppTextForm(
                              controller: firstname,
                              hintText: 'ชื่อ',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'กรุณากรอกชื่อ';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'เบอร์โทร',
                                  style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            AppTextForm(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              hintText: 'เบอร์โทรศัพท์',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'กรุณากรอกเบอร์โทรศัพท์';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'อีเมล',
                                  style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            AppTextForm(
                              controller: email,
                              hintText: 'อีเมล',
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'กรุณากรอกอีเมล';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            ButtonOnClick(
                              size: size,
                              press: () async {
                                if (editFormKey.currentState!.validate()) {
                                  try {
                                    LoadingDialog.open(context);
                                    if (image != null) {
                                      final _edit = await SettingApi.editProfileUser(file: image, name: firstname.text, email: email.text, tel: phone.text);
                                      //LoadingDialog.close(context);
                                      if (_edit == '201') {
                                        if (!mounted) return;
                                        final _ok = await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialogYes(
                                            title: 'สำเร็จ',
                                            description: 'แก้ใขโปรไฟล์สำเร็จ',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                        if (_ok == true) {
                                          getUserProfile();
                                        }
                                      } else {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'แจ้งเตือน',
                                            description: 'เกิดข้อผิดพลาดจากระบบ โปรดติดต่อแอดมิน',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      final _edit = await SettingApi.editProfileUser(file: image, name: firstname.text, email: email.text, tel: phone.text);
                                      LoadingDialog.close(context);
                                      if (_edit == '201') {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'สำเร็จ',
                                            description: 'แก้ใขโปรไฟล์สำเร็จ',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                      } else {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'แจ้งเตือน',
                                            description: 'เกิดข้อผิดพลาดจากระบบ โปรดติดต่อแอดมิน',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                      }
                                    }

                                    if (!mounted) return;
                                    LoadingDialog.close(context);
                                  } on Exception catch (e) {
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
                              buttonName: 'บันทึก',
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            ButtonOnClick(
                              size: size,
                              buttonName: 'ลบแอคเคาท์',
                              press: () async {
                                try {
                                  LoadingDialog.open(context);
                                  final _ok = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialogYesNo(
                                      title: 'แจ้งเตือน',
                                      description: 'ต้องการลบแอคเคาท์หรือไม่',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                      pressNo: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                  );
                                  if (_ok == true) {
                                    final _delete = await SettingApi.deletAccount(user.id);
                                    if (_delete == '201') {                                      
                                      if (!mounted) return;
                                      LoadingDialog.close(context);
                                      final _success = await showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => AlertDialogYes(
                                          title: 'สำเร็จ',
                                          description: 'ลบแอคเคาท์สำเร็จ',
                                          pressYes: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      );
                                      if (_success == true) {
                                        if (!mounted) return;
                                        context.read<LoginController>().clearToken().then((value) {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                        });
                                      }
                                    } else {
                                      if (!mounted) return;
                                      LoadingDialog.close(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialogYes(
                                          title: 'แจ้งเตือน',
                                          description: 'เกิดข้อผิดพลาดจากระบบ โปรดติดต่อแอดมิน',
                                          pressYes: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      );
                                    }
                                  }else{
                                    if (!mounted) return;
                                    LoadingDialog.close(context);
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
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
