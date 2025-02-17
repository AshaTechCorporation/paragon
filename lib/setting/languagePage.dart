import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  bool langTH = true;
  bool langEN = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isPhone(context) ? size.height * 0.14 : size.height * 0.10),
        child: Container(
          height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/red_appBar_pic.png'), fit: BoxFit.fill),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.025, horizontal: size.width * 0.01),
                child: BackButtonOnClick(
                  size: size,
                  press: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
              Text(
                'ภาษา',
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    'เลือกภาษาที่ต้องการ',
                    style: TextStyle(fontSize: isPhone(context)?20:30, color: kFontDesColor),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                langTH = true;
                                langEN = false;
                              });
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/icons/th.png'),
                            ),
                          ),
                          langTH == true ? Positioned(bottom: 0, right: 0, child: Image.asset('assets/icons/mingcute_check-2-fill.png')) : SizedBox.shrink(),
                        ],
                      ),
                      Text('ภาษาไทย',style: TextStyle(fontSize: isPhone(context)?20:30, color: kFontDesColor), ),
                    ],
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                langTH = false;
                                langEN = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/icons/en.png'),
                            ),
                          ),
                          langEN == true ? Positioned(bottom: 0, right: 0, child: Image.asset('assets/icons/mingcute_check-2-fill.png')) : SizedBox.shrink()
                        ],
                      ),
                      Text('ภาษาอังกฤษ',style: TextStyle(fontSize: isPhone(context)?20:30, color: kFontDesColor),),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.08,
              ),
              ButtonOnClick(
                size: size,
                press: () {
                  Navigator.pop(context);
                },
                buttonName: 'บันทึก',
              ),

              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       langTH = true;
              //       langEN = false;
              //     });
              //   },
              //   child: Card(
              //     margin: EdgeInsets.zero,
              //     elevation: 0,
              //     color: Color.fromARGB(255, 238, 234, 234),
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //         color: Color.fromARGB(255, 238, 231, 231),
              //         width: 2.0,
              //       ),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Container(
              //       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              //       child: ListTile(
              //         contentPadding: EdgeInsets.all(0),
              //         dense: false,
              //         leading: ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Image.asset(
              //             'assets/icons/th.png',
              //             height: size.height * 0.08,
              //             width: size.width * 0.12,
              //             fit: BoxFit.fill,
              //           ),
              //         ),
              //         title: Center(
              //           child: Text(
              //             'ภาษาไทย',
              //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         trailing: langTH == true
              //             ? Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Icon(
              //                   Icons.check,
              //                   color: Colors.green,
              //                 ),
              //             )
              //             : SizedBox.shrink(),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // //Divider(color: kBordercolor, thickness: 2,),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       langTH = false;
              //       langEN = true;
              //     });
              //   },
              //   child: Card(
              //     margin: EdgeInsets.zero,
              //     elevation: 0,
              //     color: Color.fromARGB(255, 238, 234, 234),
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //         color: Color.fromARGB(255, 238, 231, 231),
              //         width: 2.0,
              //       ),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Container(
              //       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              //       child: ListTile(
              //         contentPadding: EdgeInsets.all(0),
              //         dense: false,
              //         leading: ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Image.asset(
              //             'assets/icons/en.png',
              //             height: size.height * 0.08,
              //             width: size.width * 0.12,
              //             fit: BoxFit.fill,
              //           ),
              //         ),
              //         title: Center(
              //           child: Text(
              //             'English',
              //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         trailing: langEN == true
              //             ? Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Icon(
              //                   Icons.check,
              //                   color: Colors.green,
              //                 ),
              //             )
              //             : SizedBox.shrink(),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
