import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/job/services/jobController.dart';
import 'package:paragon/models/job.dart';
import 'package:paragon/models/user.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  JobPage({super.key, this.eventDate});
  DateTime? eventDate;  

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  User? user;
  List<Job> jobs = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getAllJobs());
  }

  Future<void> getAllJobs() async {
    LoadingDialog.open(context);
    try {
      await context.read<HomeController>().getProfileUser();
      setState(() {
        user = context.read<HomeController>().user;
      });
      final List<String> status = ['assign','finish','reject'];
      if (widget.eventDate != null) {
        await context.read<JobController>().getListAllJobs(start: 0, length: 1000, status: status, eventDate: widget.eventDate!, user_id: user!.id, customer_id: 0);
        setState(() {
          jobs = context.read<JobController>().eventJobs;
        });
      } else {
        await context.read<JobController>().getListAllJobs(start: 0, length: 1000, status: status, eventDate: DateTime.now(), user_id: user!.id, customer_id: 0);
        setState(() {
          jobs = context.read<JobController>().jobs;
        });
      }
      
      //await context.read<JobController>().getListJobs();
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
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.015, horizontal: size.width * 0.01),
                  child: BackButtonOnClick(
                    size: size,
                    press: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                Text(
                  'งานของฉัน',
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
        body: Consumer<JobController>(builder: (context, jobcontroller, child) {
          //final jobs = jobcontroller.eventJobs;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                jobs.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                              jobs.length,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                    child: Container(
                                      //height: size.height * 0.22,
                                      width: size.width * 0.90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(18)),
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
                                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  ),
                                                  child: jobs[index].image != null
                                                  ?Image.network(jobs[index].image!, fit: BoxFit.fill, height: size.height * 0.18)
                                                  :Image.asset('assets/images/user_image_20250217_11332671108af0061.png', fit: BoxFit.fill, height: size.height * 0.18,),
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'PO.NO : ${jobs[index].po_no}',
                                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 12 : 20,),
                                                    ),
                                                    Text(
                                                      'JOB.NO : ${jobs[index].code}',
                                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 12 : 20,),
                                                    ),
                                                    Text(
                                                      'วันที่ : ${jobs[index].pm_date}',
                                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 12 : 20,),
                                                    ),
                                                    Text(
                                                      'สถานที่ : ${jobs[index].project}',
                                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 12 : 20,),
                                                    ),
                                                    Text(
                                                      'ผู้รับผิดชอบ : ${jobs[index].user_assign ?? '-'}',
                                                      style: TextStyle(color: kTextForgotPasswordColor, fontSize: isPhone(context) ? 12 : 20,),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.01),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) => JobEngineerPage(
                                                          //               id: jobs[index].id,
                                                          //             )));
                                                        },
                                                        child: Container(
                                                          height: isPhone(context) ? size.height * 0.04 : size.height * 0.05,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(color: kButtonContainerColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                          //color: kButtonContainerColor,
                                                          child: Center(
                                                            child: Text(
                                                              'บันทึกรายละเอียดงาน',
                                                              style: TextStyle(color: kNaviPrimaryColor, fontSize: isPhone(context) ? 12 : 22),
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
                                  )),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
