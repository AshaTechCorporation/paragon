import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/job/services/jobApi.dart';
import 'package:paragon/job/services/jobController.dart';
import 'package:paragon/models/job.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/setting/settingPage.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/ButtonAppbar.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  CalendarCarousel? _calendarCarouselNoHeader;
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});
  List<DateTime> dateTime = [];
  List<Job> jobsList = [];
  List<Job> jobs = [];

  User? user;
  DateTime? apiDateTime;
  bool? isToday;
  String? dateFromApi;
  int? index;
  bool hasDisplayedNonTodayJob = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getAllJobs());
    getjoplits();
  }

  static final Widget eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  Future<void> getAllJobs() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
      });
      final List<String> status = ['assign', 'finish', 'reject'];
      await context.read<JobController>().getListAllJobs(
          start: 0,
          length: 1000,
          status: status,
          eventDate: DateTime.now(),
          user_id: user!.id,
          customer_id: 0);
      setState(() {
        dateTime.clear();
        for (var i = 0; i < context.read<JobController>().jobs.length; i++) {
          dateTime.add(DateFormat('y-M-d')
              .parse(context.read<JobController>().jobs[i].pm_date!));
          if (context.read<JobController>().jobs[i].status != 'finish' &&
              context.read<JobController>().jobs[i].status != 'close') {
            _markedDateMap.add(
                DateTime(dateTime[i].year, dateTime[i].month, dateTime[i].day),
                Event(
                  date: DateTime(
                      dateTime[i].year, dateTime[i].month, dateTime[i].day),
                  title: 'Event ${i}',
                  icon: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        border: Border.all(color: Colors.blue, width: 2.0)),
                    child: IconButton(
                        onPressed: () {
                          print('object');
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.amber,
                        )),
                  ),
                ));
          }
        }
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

  Future<void> getjoplits() async {
    await context.read<HomeController>().getProfileUser();
    setState(() {
      user = context.read<HomeController>().user;
    });
    final List<String> status = ['assign', 'finish', 'reject'];
    jobsList.clear();
    jobsList = await JobApi.getMeJobs(
        start: 0,
        length: 1000,
        status: status,
        user_id: user!.id,
        customer_id: 0);
    jobs = jobsList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      nextDaysTextStyle: TextStyle(fontSize: isPhone(context) ? 18 : 28),
      weekdayTextStyle: TextStyle(fontSize: isPhone(context) ? 18 : 28),
      markedDateMoreCustomTextStyle:
          TextStyle(fontSize: isPhone(context) ? 18 : 28),
      daysTextStyle:
          TextStyle(fontSize: isPhone(context) ? 18 : 28, color: Colors.black),
      inactiveWeekendTextStyle: TextStyle(fontSize: isPhone(context) ? 18 : 28),
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) async {
        //print('object');
        setState(() => _currentDate2 = date);
        if (events.isNotEmpty) {
          //inspect(events);
          if (events[0].date == _currentDate2) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => JobPage(
            //               eventDate: _currentDate2,
            //             )));
          }
        }
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
        fontSize: isPhone(context) ? 18 : 28,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: isPhone(context) ? size.height * 0.45 : size.height * 0.50,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: isPhone(context) ? 18 : 28,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
        fontSize: isPhone(context) ? 18 : 28,
      ),

      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
        fontSize: isPhone(context) ? 18 : 28,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: isPhone(context) ? 16 : 26,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: isPhone(context) ? 16 : 26,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return SafeArea(child:
        Consumer<JobController>(builder: (context, jobcontroller, child) {
      final eventJob = jobcontroller.eventJobs;
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  isPhone(context) ? size.height * 0.14 : size.height * 0.10),
              child: Container(
                height:
                    isPhone(context) ? size.height * 0.14 : size.height * 0.11,
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
                          vertical: size.height * 0.015,
                          horizontal: size.width * 0.01),
                      child: ButtonAppbar(
                        size: size,
                        press: () async {
                          final go = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingPage()));
                          if (go == true) {
                          } else {}
                        },
                      ),
                    ),
                    Text(
                      'ตารางงานช่าง',
                      style: TextStyle(
                          color: kTextHeadColor,
                          fontSize: isPhone(context) ? 24 : 35,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: isPhone(context)
                          ? size.height * 0.05
                          : size.height * 0.07,
                      width: isPhone(context)
                          ? size.width * 0.12
                          : size.width * 0.14,
                    )
                  ],
                ),
              )),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        _currentMonth,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isPhone(context) ? 24 : 35,
                        ),
                      )),
                      TextButton(
                        child: Text(
                          'PREV',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isPhone(context) ? 15 : 25,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      TextButton(
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isPhone(context) ? 15 : 25,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: isPhone(context) ? 15 : 25,
                    ),
                    child: _calendarCarouselNoHeader,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'รายการงานวันนี้',
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: isPhone(context) ? 20 : 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(jobs.length, (index) {
                              if (jobs.isNotEmpty) {
                                dateFromApi = jobs[index].pm_date ?? '';
                                apiDateTime = DateFormat("yyyy-MM-dd")
                                    .parse(dateFromApi!);
                                DateTime currentDateTime = DateTime.now();
                                isToday = apiDateTime!.isAtSameMomentAs(
                                  DateTime(
                                    currentDateTime.year,
                                    currentDateTime.month,
                                    currentDateTime.day,
                                  ),
                                );
                              }
                              return isToday == true
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        //height: size.height * 0.22,
                                        width: size.width * 0.90,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
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
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.02,
                                                      vertical:
                                                          size.height * 0.01),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    child: jobs[index].image !=
                                                            null
                                                        ? Image.network(
                                                            jobs[index].image!,
                                                            fit: BoxFit.fill,
                                                            height:
                                                                size.height *
                                                                    0.20)
                                                        : Image.asset(
                                                            'assets/images/logo.png',
                                                            fit: BoxFit.fill,
                                                            height:
                                                                size.height *
                                                                    0.20,
                                                          ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.height * 0.01),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'เลข PO : ${jobs[index].po_no}',
                                                        style: TextStyle(
                                                          color:
                                                              kTextForgotPasswordColor,
                                                          fontSize:
                                                              isPhone(context)
                                                                  ? 12
                                                                  : 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'หมายเลขงาน : ${jobs[index].code}',
                                                        style: TextStyle(
                                                          color:
                                                              kTextForgotPasswordColor,
                                                          fontSize:
                                                              isPhone(context)
                                                                  ? 12
                                                                  : 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'วันที่ : ${jobs[index].pm_date}',
                                                        style: TextStyle(
                                                          color:
                                                              kTextForgotPasswordColor,
                                                          fontSize:
                                                              isPhone(context)
                                                                  ? 12
                                                                  : 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'สถานที่ : ${jobs[index].project}',
                                                        style: TextStyle(
                                                          color:
                                                              kTextForgotPasswordColor,
                                                          fontSize:
                                                              isPhone(context)
                                                                  ? 12
                                                                  : 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        'ผู้รับผิดชอบ : ${jobs[index].finish_by ?? ''}',
                                                        style: TextStyle(
                                                          color:
                                                              kTextForgotPasswordColor,
                                                          fontSize:
                                                              isPhone(context)
                                                                  ? 12
                                                                  : 20,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        0.02,
                                                                vertical:
                                                                    size.height *
                                                                        0.01),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder:
                                                            //             (context) =>
                                                            //                 JobEngineerPage(
                                                            //                   id: jobs[index].id,
                                                            //                 )));
                                                          },
                                                          child: Container(
                                                            height: isPhone(
                                                                    context)
                                                                ? size.height *
                                                                    0.04
                                                                : size.height *
                                                                    0.05,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kButtonContainerColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            //color: kButtonContainerColor,
                                                            child: Center(
                                                              child: Text(
                                                                'บันทึกรายละเอียดงาน',
                                                                style: TextStyle(
                                                                    color:
                                                                        kNaviPrimaryColor,
                                                                    fontSize:
                                                                        isPhone(context)
                                                                            ? 12
                                                                            : 22),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink();
                            }),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.10,
                ),
              ])));
    }));
  }
}
