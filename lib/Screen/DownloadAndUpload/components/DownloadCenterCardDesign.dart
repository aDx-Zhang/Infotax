import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Model/DownloadDoc.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/PdfFileScreen.dart';
import 'package:info_tax_square/Utils/AppUtils.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class DownloadCenterCardDesign extends StatefulWidget {
  DownloadCenterCardDesign({Key? key, required this.downloadDoc,required this.index, required this.controller})
      : super(key: key);
  DownloadDoc downloadDoc;
  var index;
  DocumentController controller;

  @override
  State<DownloadCenterCardDesign> createState() => _DownloadCenterCardDesignState();
}

class _DownloadCenterCardDesignState extends State<DownloadCenterCardDesign> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.colorDarkGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.downloadDoc.docName,
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Bonus Invoice  ",
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        formatDate2(widget.downloadDoc.ddate),
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          TextButton(onPressed: () async{
           await widget.controller.downloadPdf(widget.downloadDoc.fileUrl, widget.downloadDoc.docName, context,_onReceiveProgress );
          }, child: Text("Download", style: TextStyle(color: Colors.green.shade700),)),
          progress!=0 ? LinearProgressIndicator(
            value: progress,
            color: AppColors.colorDarkGrey,
          ) : SizedBox()
        ],
      ),
    );
  }

  _onReceiveProgress(receive, total) {
    double progres = receive / total;
    setState(() {
      progress = progres;
      print("progress ${progress}");
    });

  }
}
