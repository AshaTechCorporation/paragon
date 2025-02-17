import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class AlertDialogTel extends StatelessWidget {
  AlertDialogTel({
    Key? key,
    required this.pressYes,
  }) : super(key: key);
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: pressYes,
                  child: Image.asset('assets/icons/carbon_close-outline.png')),
            ],
          ),
          Center(
              child: Text(
            'กรุณาติดต่อ',
            style: TextStyle(
                fontSize: isPhone(context) ? 30 : 40,
                color: kIndigatorColor,
                fontWeight: FontWeight.bold),
          )),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Image.asset(
                  'assets/icons/icon_call.png',
                  color: kIndigatorColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, '064-445-5577');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Text(
                    '064-445-5577',
                    style: TextStyle(
                      fontSize: isPhone(context) ? 25 : 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Image.asset(
                  'assets/icons/icon_call.png',
                  color: kIndigatorColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, '086-466-8783');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Text(
                    '086-466-8783',
                    style: TextStyle(
                      fontSize: isPhone(context) ? 25 : 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // content: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Divider(thickness: 2,),
      //     Text(
      //       'description',
      //       style: TextStyle(
      //         fontSize: 18,
      //       ),
      //     ),
      //     Divider(thickness: 2,),
      //     Text(
      //       'description',
      //       style: TextStyle(
      //         fontSize: 18,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class AlertDialogLocale extends StatelessWidget {
  AlertDialogLocale({
    Key? key,
    required this.pressYes,
  }) : super(key: key);
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'เลือกภาษา',
                style: TextStyle(
                    fontSize: isPhone(context) ? 20 : 40,
                    color: kIndigatorColor,
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                  onTap: pressYes,
                  child: Image.asset(
                    'assets/icons/XIcon.png',
                    scale: 10,
                  )),
            ],
          )),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Image.asset(
                  'assets/icons/27145.jpg',
                  scale: 90,
                ),
              ),
              InkWell(
                onTap: () {
                  context.setLocale(Locale('th'));
                  print(context.locale.toString());
                  Navigator.pop(
                    context,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Text(
                    'ภาษาไทย',
                    style: TextStyle(
                      fontSize: isPhone(context) ? 22 : 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Image.asset(
                  'assets/icons/18166.jpg',
                  scale: 90,
                ),
              ),
              InkWell(
                onTap: () {
                  // context.setLocale(Locale('en'));

                  // print(context.locale.toString());
                  // Navigator.pop(
                  //   context,
                  // );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Text(
                    'ภาษาอังกฤษ',
                    style: TextStyle(
                      fontSize: isPhone(context) ? 22 : 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
