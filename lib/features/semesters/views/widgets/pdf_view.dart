import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  PDFViewer({super.key, required this.url});
  String url;

  // final String testUrl =
  //     'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PDF Viewer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SfPdfViewer.network(
        url,
        // testUrl,
        onDocumentLoadFailed: (details) {
          print('Failed to load PDF: ${details.error}');
          print('Error Description: ${details.description}');
        },
      ),
    );
  }
}
