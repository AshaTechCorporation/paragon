import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReport extends StatefulWidget {
  const PdfReport({super.key, required this.pathPdf});
  final String pathPdf;

  @override
  State<PdfReport> createState() => _PdfReportState();
}

class _PdfReportState extends State<PdfReport> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  'ใบแจ้งซ่อม',
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
        body: SfPdfViewer.network(
          '${widget.pathPdf}',
          key: pdfViewerKey,
        ),
      ),
    );
  }
}
