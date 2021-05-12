import 'package:crisis/Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class HomeTreatment extends StatefulWidget {
  @override
  _HomeTreatmentState createState() => _HomeTreatmentState();
}

class _HomeTreatmentState extends State<HomeTreatment> {
  static final int _initialPage = 2;
  int _actualPageNumber = _initialPage, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController _pdfController;

  void initState() {
    super.initState();
    _pdfController = PdfController(
      document:
          PdfDocument.openAsset('assets/RevisedGuidelineshomeisolation4.pdf'),
      initialPage: _initialPage,
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PdfView(
          scrollDirection: Axis.vertical,
          documentLoader: Center(child: Loading()),
          pageLoader: Center(child: Loading()),
          controller: _pdfController,
          onDocumentLoaded: (document) {
            setState(() {
              _allPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              _actualPageNumber = page;
            });
          },
        ),
      ),
    );
  }
}
