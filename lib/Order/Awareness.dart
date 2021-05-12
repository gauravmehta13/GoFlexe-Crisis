import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class Awareness extends StatefulWidget {
  @override
  _AwarenessState createState() => _AwarenessState();
}

class _AwarenessState extends State<Awareness> {
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
          documentLoader: Center(child: CircularProgressIndicator()),
          pageLoader: Center(child: CircularProgressIndicator()),
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
