import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/home/firstPage.dart';
import 'package:paragon/job/services/jobApi.dart';
import 'package:paragon/job/services/jobController.dart';
import 'package:paragon/utils/formattedMessage.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/AppTextForm.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:paragon/widgets/ButtonOnClick.dart';
import 'package:paragon/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class JobEngineerPage extends StatefulWidget {
  JobEngineerPage({super.key, required this.id});
  final int id;

  @override
  State<JobEngineerPage> createState() => _JobEngineerPageState();
}

class _JobEngineerPageState extends State<JobEngineerPage> {
  final GlobalKey<FormState> saveJobFormKey = GlobalKey<FormState>();
  final TextEditingController poNumber = TextEditingController();
  final TextEditingController jobNumber = TextEditingController();
  final TextEditingController pmDate = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController notificationNote = TextEditingController();
  bool open_qr = false;

  Future<void> getJobById() async {
    LoadingDialog.open(context);
    try {
      await context.read<JobController>().getJobId(id: widget.id);
      setState(() {
        poNumber.text = context.read<JobController>().job!.po_no ?? '';
        jobNumber.text = context.read<JobController>().job!.code ?? '';
        pmDate.text = context.read<JobController>().job!.pm_date ?? '';
        location.text = context.read<JobController>().job!.location ?? '';
        notificationNote.text = context.read<JobController>().job!.remark ?? '';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getJobById());
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
              image: DecorationImage(image: AssetImage('assets/images/appBar_pic.png'), fit: BoxFit.fill),
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
          final job = jobcontroller.job;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: job != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'PO.NO',
                              style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AppTextForm(
                          controller: poNumber,
                          hintText: '',
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
                              'JOB.NO',
                              style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AppTextForm(
                          controller: jobNumber,
                          hintText: '',
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
                              'PM & Test Date',
                              style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AppTextForm(
                          controller: pmDate,
                          hintText: '',
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
                              'สถานที่',
                              style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AppTextForm(
                          controller: location,
                          hintText: '',
                          maxline: 2,
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
                              'หมายเหตุการแจ้งเตือน',
                              style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AppTextForm(
                          controller: notificationNote,
                          hintText: '',
                          maxline: 4,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'กรุณากรอกชื่อ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        job.qr_code != null
                        ?InkWell(
                          onTap: (){
                            setState(() {
                              if (open_qr == true) {
                                open_qr = false;
                              } else {
                                open_qr = true;
                              }
                            });
                          },
                          child: Text(
                            'แสดง QR-CODE',
                            style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 20 : 30, fontWeight: FontWeight.bold),
                          ),
                        ):SizedBox(),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        open_qr == true
                        ?Image.network(job.qr_code!)
                        :SizedBox(),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('Generator Specifications & Commissioning', style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 25 : 30, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        //ส่วนที่จะโชว์ เทมเพลต
                        job.job_parts!.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
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
                                child: ExpansionPanelList(
                                  materialGapSize: 10,
                                  expandedHeaderPadding: EdgeInsets.symmetric(vertical: 10),
                                  expansionCallback: (i, isOpen) => setState(() {
                                    job.job_parts![i].isOpen = isOpen;
                                  }),
                                  children: List.generate(
                                      job.job_parts!.length,
                                      (index) => ExpansionPanel(
                                          isExpanded: job.job_parts![index].isOpen,
                                          headerBuilder: (context, isOpen) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: size.height * 0.01),
                                              child: Text('${job.job_parts?[index].part?.part_no ?? ''}: ${job.job_parts?[index].part?.name ?? ''}',
                                                  style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold)),
                                            );
                                          },
                                          body: job.job_parts![index].job_part_templates!.isNotEmpty
                                              ? Column(
                                                  children: List.generate(
                                                      job.job_parts![index].job_part_templates!.length,
                                                      (index2) => Padding(
                                                            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: size.width * 0.01),
                                                            child: Card(
                                                              elevation: 1,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10),
                                                                child: GestureDetector(
                                                                  onTap: () async {
                                                                    if (job.job_parts![index].job_part_templates![index2].template_id == 30 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 31 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 57 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 58 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 59 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 60 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 61 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 62 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 63 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 64 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 65 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 66 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 67 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 68 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 69 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 70 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 71 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 72 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 75 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 78 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 79 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 80 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 81 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 82 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 83 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 84 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 85 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 86 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 87 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 88 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 89 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 90 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 91 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 92 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 93 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 94 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 99 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 100 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 109 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 110 ||
                                                                        job.job_parts![index].job_part_templates![index2].template_id == 111) {
                                                                      if (!mounted) return;
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (context) => AlertDialogYes(
                                                                          title: 'แจ้งเตือน',
                                                                          description: 'ฟอร์มเอกสารนี้ถูกกำหนค่าเอาไว้ ไม่มีฟอร์มให้กรอกข้อมูล',
                                                                          pressYes: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      // final check = await Navigator.push(
                                                                      //     context,
                                                                      //     MaterialPageRoute(
                                                                      //         builder: (context) => JobDetailTemplate(
                                                                      //             id: job.id,
                                                                      //             pm_date: job.pm_date!,
                                                                      //             jobId: job.job_parts![index].job_part_templates![index2].id,
                                                                      //             templateId: job.job_parts![index].job_part_templates![index2].template_id!,
                                                                      //             nameTemplate: job.job_parts![index].job_part_templates![index2].template!.name,
                                                                      //             status: job.status!)));
                                                                      // if (check == true) {
                                                                      //   getJobById();
                                                                      // } else {}
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                    height: size.height * 0.10,
                                                                    color: Colors.white,
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          color: job.job_parts![index].job_part_templates![index2].checked == true ? Colors.green : Colors.orange,
                                                                          width: size.width * 0.14,
                                                                          height: size.height * 0.10,
                                                                          child: job.job_parts![index].job_part_templates![index2].checked == true
                                                                              ? Icon(Icons.check_box, color: Colors.white)
                                                                              : Icon(Icons.disabled_by_default, color: Colors.white),
                                                                        ),
                                                                        SizedBox(width: 10),
                                                                        Expanded(
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text('${job.job_parts![index].job_part_templates![index2].template!.name}',
                                                                                  style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Icon(Icons.arrow_forward_ios, color: Colors.blue),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                )
                                              : SizedBox())),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        job.status == 'assign' || job.status == 'reject'
                            ? ButtonOnClick(
                                size: size,
                                buttonName: 'ยืนยันจบงาน',
                                press: () async {
                                  try {
                                    final _ok = await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialogYesNo(
                                        title: 'แจ้งเตือน',
                                        description: 'คุณต้องการที่จะปิดงานหรือไม่',
                                        pressYes: () {
                                          Navigator.pop(context, true);
                                        },
                                        pressNo: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    );
                                    if (_ok == true) {
                                      LoadingDialog.open(context);
                                      final confirm = await JobApi.confirmJob(id: widget.id);
                                      LoadingDialog.close(context);
                                      if (confirm != null) {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'แจ้งเตือน',
                                            description: 'งานของคุณสำเร็จแล้ว',
                                            pressYes: () {
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
                                            },
                                          ),
                                        );
                                      } else {
                                        if (!mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'แจ้งเตือน',
                                            description: 'เกิดข้อผิดพลาดปิดงานไม่ได้',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                      }
                                    }
                                  } on Exception catch (e) {
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
                                },
                              )
                            : SizedBox(),

                        SizedBox(
                          height: size.height * 0.05,
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
          );
        }),
      ),
    );
  }
}
