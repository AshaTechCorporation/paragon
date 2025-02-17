import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/document/documentPage.dart';
import 'package:paragon/home/homePage.dart';
import 'package:paragon/notification/notificationPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

enum _SelectedTab { home, doc, noti }

class _FirstPageState extends State<FirstPage> {final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];

      if (_selectedTab == _SelectedTab.home) {
        currentScreen = HomePage();
      } else if (_selectedTab == _SelectedTab.doc) {
        currentScreen = DocumentPage();
      } else if (_selectedTab == _SelectedTab.noti) {
        currentScreen = NotificationPage();
      } else {}
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: Stack(
          children: [
            Padding(
              padding: isPhone(context) ? EdgeInsets.fromLTRB(15, 15, 15, 15) : EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Card(
                elevation: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  height: isPhone(context) ? 80 : 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,
                      type: BottomNavigationBarType.fixed,
                      items: <BottomNavigationBarItem>[
                        _selectedTab == _SelectedTab.home
                            ? BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/Vector.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Color(0xffFA5A0E),
                                ),
                                label: 'หน้าแรก'
                              )
                            : BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/Vector.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Colors.grey,
                                ),
                                label: 'หน้าแรก',
                              ),
                        _selectedTab == _SelectedTab.doc
                            ? BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/Group.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Color(0xffFA5A0E),
                                ),
                                label: 'เอกสาร',
                              )
                            : BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/Group.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Colors.grey,
                                ),
                                label: 'เอกสาร'),
                        _selectedTab == _SelectedTab.noti
                            ? BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/navi.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Color(0xffFA5A0E),
                                ),
                                label: 'แจ้งเตือน')
                            : BottomNavigationBarItem(
                                icon: Image.asset(
                                  'assets/icons/navi.png',
                                  scale: isPhone(context) ? 20 : 10,
                                  color: Colors.grey,
                                ),
                                label: 'แจ้งเตือน'),
                        
                      ],
                      currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Color(0xffFA5A0E),
                      selectedFontSize: 14,
                      unselectedFontSize: 14,
                      onTap: _handleIndexChanged,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
       
        );
  }
}