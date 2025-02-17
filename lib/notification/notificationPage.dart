import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/models/notify.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/notification/services/notifyApi.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notify> notify = [];
  User? user;
  int length = 10;
  int start = 1;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getNotify(length: length, start: start));
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      notify.clear();
      length = 10;
      start = 1;
    });
    getNotify(length: length, start: start);
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    //if (mounted) return;
    
    refreshController.refreshCompleted();
    setState(() {});
  }

  void _onLoading() async {
    // monitor network fetch
    setState(() {
      start = start + 1;
      length = length + 10;
    });
    getNotify(length: length, start: start);
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    //if (mounted) return;
    
    refreshController.loadComplete();
    setState(() {});
  }

  void getNotify({required int length, required int start}) async {
    LoadingDialog.open(context);
    try {
      user = await context.read<HomeController>().user;
      final _notify = await NotifyApi.getMeJobs(start: start, length: length, user_id: user!.id);
      setState(() {
        //notify.clear();
        //notify = _notify;
        notify.addAll(_notify);
        //notify = _notify.toList().reversed.toList();
      });
      LoadingDialog.close(context);
    } on Exception catch (e) {
      LoadingDialog.close(context);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('แจ้งเตือน'),
          content: Text('${e.getMessage}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'),
            ),
          ],
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
            height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/red_appBar_pic.png'), fit: BoxFit.fill),
            ),
            child: Center(
              child: Text(
                'การแจ้งเตือน',
                style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget? body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("");
              } else {
                body = Text("");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                notify.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                              notify.length,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (notify[index].notify_log!.type == 'job') {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => JobEngineerPage(
                                          //               id: int.parse(notify[index].notify_log!.target_id!),
                                          //             )));
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => JobPage()));
                                        } else {}
                                      },
                                      child: Container(
                                        //height: size.height * 0.19,
                                        width: size.width * 0.90,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: 2,
                                              spreadRadius: 2,
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            // assets/icons/noti_pic.png
                                            notify[index].notify_log!.image != null
                                                ? Image.network(
                                                    notify[index].notify_log!.image!,
                                                    scale: isPhone(context) ? 1.3 : 0.8,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image.asset(
                                                      'assets/icons/noti_pic.png',
                                                      scale: isPhone(context) ? 1.3 : 0.8,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            Expanded(
                                                flex: 7,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'ประเภท : ${notify[index].notify_log!.type}',
                                                        style: TextStyle(
                                                          color: kTextForgotPasswordColor,
                                                          fontSize: isPhone(context) ? 15 : 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        'วันที่ : ${DateFormat('dd-MM-yyyy').format(notify[index].created_at!)}',
                                                        style: TextStyle(
                                                          color: kTextForgotPasswordColor,
                                                          fontSize: isPhone(context) ? 15 : 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        'เรื่อง : ${notify[index].notify_log!.title}',
                                                        style: TextStyle(
                                                          color: kTextForgotPasswordColor,
                                                          fontSize: isPhone(context) ? 15 : 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        'รายละเอียด : ${notify[index].notify_log!.detail}',
                                                        style: TextStyle(
                                                          color: kTextForgotPasswordColor,
                                                          fontSize: isPhone(context) ? 15 : 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      )
                    : SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.35,
                            ),
                            Center(
                              child: Text(
                                'ไม่พบข้อมูล...',
                                style: TextStyle(color: kTextHeadColor, fontSize: isPhone(context) ? 24 : 35, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
