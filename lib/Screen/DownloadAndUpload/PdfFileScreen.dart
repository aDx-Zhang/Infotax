

import 'dart:io';

import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class PdfFileScreen extends StatefulWidget {
  PdfFileScreen({Key? key, required this.path,required this.isUrl}) : super(key: key);
  String path;
  bool isUrl;
  @override
  State<PdfFileScreen> createState() => _PdfFileScreenState();
}

class _PdfFileScreenState extends State<PdfFileScreen> {
  bool _isLoading = true;
  late PDFDocument document;
  bool _usePDFListView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorSecondary,
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back)),
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator(),) : PDFViewer(
          document: document,

        ),
    );
  }
  @override
  void initState() {
    super.initState();
    loadDocument();
  }
  @override
  void dispose() {
    document.clearImageCache();
    document.clearFileCache();
    super.dispose();
  }
  loadDocument() async {
    if(widget.isUrl){
      document = await PDFDocument.fromURL(widget.path);
    }
    else{
      document = await PDFDocument.fromFile(
       File( widget.path)
      );
    }


    setState(() => _isLoading = false);
  }
}
