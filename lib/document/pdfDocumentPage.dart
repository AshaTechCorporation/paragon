import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:paragon/constants.dart';
import 'package:paragon/widgets/AlertDialogYesNo.dart';
import 'package:paragon/widgets/BackButtonOnClick.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfDocumentPage extends StatefulWidget {
  PdfDocumentPage({super.key, required this.path, required this.pathPdf});
  final String path;
  final String pathPdf;

  @override
  State<PdfDocumentPage> createState() => _PdfDocumentPageState();
}

class _PdfDocumentPageState extends State<PdfDocumentPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  Uint8List? imageFile;
  final Dio dio = Dio();
  double progress = 0;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<int>? _documentBytes;

  @override
  void initState() {
    super.initState();
    print(widget.pathPdf);
  }

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          //newPath = newPath + "/RPSApp";
          newPath = newPath;
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName");
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'Error',
          description: '$e',
          pressYes: () {
            Navigator.pop(context, true);
          },
        ),
      );
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              isPhone(context) ? size.height * 0.14 : size.height * 0.10),
          child: Container(
            height: isPhone(context) ? size.height * 0.14 : size.height * 0.11,
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
                  child: BackButtonOnClick(
                    size: size,
                    press: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                Text(
                  'เอกสาร PM',
                  style: TextStyle(
                      color: kTextHeadColor,
                      fontSize: isPhone(context) ? 24 : 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: isPhone(context)
                      ? size.height * 0.05
                      : size.height * 0.07,
                  width:
                      isPhone(context) ? size.width * 0.12 : size.width * 0.14,
                )
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_documentBytes != null) {
                        openBrowserURL(url: widget.pathPdf, inApp: false);
                        // DateTime now = DateTime.now();
                        // final String date = DateFormat('dd-MM-y-HH.mm').format(now);
                        // saveFile(widget.pathPdf, '${date}Document.pdf');
                        // if (Platform.isAndroid) {
                        //   var status = await Permission.manageExternalStorage.request();
                        //   if (status == PermissionStatus.granted) {
                        //     if (await Permission.storage.request().isGranted) {
                        //       // Permission is granted. Proceed with accessing the file.
                        //       await Permission.storage.request();
                        //       Directory directory = await getTemporaryDirectory();
                        //       directory = Directory('/storage/emulated/0/Download');
                        //       String path = directory.path;
                        //       //Create the empty file.
                        //       File file = File('$path/${DateTime.now()}${'sample.pdf'}');
                        //       await file.writeAsBytes(_documentBytes!, flush: true);
                        //         if (!mounted) return;
                        //         showDialog(
                        //           context: context,
                        //           builder: (context) => AlertDialogYes(
                        //             title: 'สำเร็จ',
                        //             description: 'โหลดเอกสารสำเร็จ',
                        //             pressYes: () {
                        //               Navigator.pop(context, true);
                        //             },
                        //           ),
                        //         );
                        //       // bool fileExists = file.existsSync();
                        //       // if (fileExists) {
                        //       //   // Proceed with opening the file.
                        //       //   print('Proceed with opening the file !!!!');
                        //       // } else {
                        //       //   // Handle the case where the file doesn't exist.
                        //       //   if (!mounted) return;
                        //       //   showDialog(
                        //       //     context: context,
                        //       //     builder: (context) => AlertDialogYes(
                        //       //       title: 'Error',
                        //       //       description: 'Handle the case where the file doesn t exist',
                        //       //       pressYes: () {
                        //       //         Navigator.pop(context, true);
                        //       //       },
                        //       //     ),
                        //       //   );
                        //       // }
                        //       //Write the PDF data retrieved from the SfPdfViewer.
                        //       //await file.writeAsBytes(_documentBytes!, flush: true);
                        //     } else {
                        //       // Permission is denied.
                        //       if (!mounted) return;
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) => AlertDialogYes(
                        //           title: 'Error',
                        //           description: 'Permission is denied',
                        //           pressYes: () {
                        //             Navigator.pop(context, true);
                        //           },
                        //         ),
                        //       );
                        //     }
                        //   } else {
                        //     if (!mounted) return;
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialogYes(
                        //         title: 'Error',
                        //         description: 'Permission denied, handle accordingly',
                        //         pressYes: () {
                        //           Navigator.pop(context, true);
                        //         },
                        //       ),
                        //     );
                        //   }
                        // } else {}
                        // if (await Permission.storage.request().isGranted) {
                        // if (await Permission.manageExternalStorage.isGranted) {
                        //   // Permission is granted. Proceed with accessing the file.
                        //   await Permission.storage.request();
                        //   // Directory directory = await getTemporaryDirectory();
                        //   // directory = Directory('/storage/emulated/0/Download');
                        //   // String path = directory.path;
                        //   //Create the empty file.
                        //   // File file = File('$path/${DateTime.now()}${'sample.pdf'}');
                        //   String savePath;
                        //   if (Platform.isIOS) {
                        //     final directory = await getApplicationDocumentsDirectory();
                        //     DateTime now = DateTime.now();
                        //     final String date = DateFormat('dd-MM-y-HH.mm').format(now);
                        //     savePath = '${directory.path}/$date-${'Document.pdf'}';
                        //     await File(savePath).writeAsBytes(_documentBytes!);
                        //     if (!mounted) return;
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialogYes(
                        //         title: 'สำเร็จ',
                        //         description: 'โหลดเอกสารสำเร็จ',
                        //         pressYes: () {
                        //           Navigator.pop(context, true);
                        //         },
                        //       ),
                        //     );
                        //   } else if (Platform.isAndroid) {
                        //     DateTime now = DateTime.now();
                        //     final String date = DateFormat('dd-MM-y-HH.mm').format(now);
                        //     savePath = '/storage/emulated/0/Download/$date-${'Document.pdf'}';
                        //     await File(savePath).writeAsBytes(_documentBytes!);
                        //     if (!mounted) return;
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialogYes(
                        //         title: 'สำเร็จ',
                        //         description: 'โหลดเอกสารสำเร็จ',
                        //         pressYes: () {
                        //           Navigator.pop(context, true);
                        //         },
                        //       ),
                        //     );
                        //   } else {
                        //     // Handle other platforms if necessary
                        //     return;
                        //   }
                        // } else {
                        //   // Permission is denied.
                        //   if (!mounted) return;
                        //   final dialog = await showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialogYes(
                        //       title: 'Error',
                        //       description: 'Permission is denied',
                        //       pressYes: () {
                        //         Navigator.pop(context, true);
                        //       },
                        //     ),
                        //   );
                        //   if (dialog == true) {
                        //     await Permission.storage.request();
                        //   }
                        // }
                      } else {
                        if (!mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialogYes(
                            title: 'Error',
                            description: 'Pdf Not Loaded Details',
                            pressYes: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        );
                      }
                      // await saveFile(widget.path, "sample.pdf");
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text(
                      //       'successfully saved to internal storage "PDF_Download" folder',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02),
                          child: Image.asset(
                            'assets/icons/dowmload.png',
                            scale: 20,
                          ),
                        ),
                        Text(
                          'ดาวน์โหลดเอกสาร',
                          style: TextStyle(
                              color: kButtonContainerColor,
                              fontSize: isPhone(context) ? 16.39 : 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 9,
              child: SfPdfViewer.network(
                '${widget.pathPdf}',
                key: _pdfViewerKey,
                onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                  // Document bytes of a PDF document loaded in SfPdfViewer.
                  _documentBytes = details.document.saveSync();
                },
              ),
            ),
            // Expanded(
            //   child: SfPdfViewer.asset(
            //     '${widget.pathPdf}',
            //     key: _pdfViewerKey,
            //     onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            //       // Document bytes of a PDF document loaded in SfPdfViewer.
            //       _documentBytes = details.document.saveSync();
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: PDFView(
            //     filePath: widget.path,
            //     enableSwipe: false,
            //     swipeHorizontal: false,
            //     autoSpacing: false,
            //     pageFling: true,
            //     pageSnap: true,
            //     defaultPage: currentPage!,
            //     fitPolicy: FitPolicy.HEIGHT,
            //     preventLinkNavigation: false, // if set to true the link is handled in flutter
            //     onRender: (_pages) {
            //       setState(() {
            //         pages = _pages;
            //         isReady = true;
            //       });
            //     },
            //     onError: (error) {
            //       setState(() {
            //         errorMessage = error.toString();
            //       });
            //       print(error.toString());
            //     },
            //     onPageError: (page, error) {
            //       setState(() {
            //         errorMessage = '$page: ${error.toString()}';
            //       });
            //       print('$page: ${error.toString()}');
            //     },
            //     onViewCreated: (PDFViewController pdfViewController) {
            //       _controller.complete(pdfViewController);
            //     },
            //     onLinkHandler: (String? uri) {
            //       print('goto uri: $uri');
            //     },
            //     onPageChanged: (int? page, int? total) {
            //       print('page change: $page/$total');
            //       setState(() {
            //         currentPage = page;
            //       });
            //     },
            //   ),
            // ),
            // errorMessage.isEmpty
            //     ? !isReady
            //         ? Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : Container()
            //     : Center(
            //         child: Text(errorMessage),
            //       )
          ],
        ),
      ),
    );
  }
}

Future openBrowserURL({
  required String url,
  bool inApp = false,
}) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(
      url,
      forceSafariVC: inApp,
      forceWebView: inApp,
      enableJavaScript: true,
      enableDomStorage: true,
    );
  }
}
