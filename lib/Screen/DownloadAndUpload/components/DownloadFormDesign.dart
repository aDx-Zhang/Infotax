import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Model/DownloadForm.dart';
import 'package:info_tax_square/Utils/AppData.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadFormDesign extends StatefulWidget {
  DownloadFormDesign({Key? key, required this.downloadForm, this.index, required this.controller})
      : super(key: key);

  DownloadForm downloadForm;
  var index;
  DocumentController controller;

  @override
  State<DownloadFormDesign> createState() => _DownloadFormDesignState();
}

class _DownloadFormDesignState extends State<DownloadFormDesign> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.colorDarkGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.downloadForm.title,
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    _launchURL(widget.downloadForm.orderNowUrl);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.colorSecondary,
                    backgroundColor: AppColors.colorSecondary,
                  ),
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                        color: AppColors.colorBackground, fontSize: 15),
                  )),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () async {
                    await widget.controller.downloadPdf(
                        widget.downloadForm.downloadUrl,
                        widget.downloadForm.title,
                        context,
                        _onReceiveProgress);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                    backgroundColor: Colors.green.shade700,
                  ),
                  child: Text(
                    "Download",
                    style: TextStyle(
                        color: AppColors.colorBackground, fontSize: 15),
                  )),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    _launchURL(widget.downloadForm.moreInfoUrl);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.yellow.shade700,
                    backgroundColor: Colors.yellow.shade700,
                  ),
                  child: Text(
                    "More Information",
                    style: TextStyle(
                        color: AppColors.colorBackground, fontSize: 15),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _onReceiveProgress(receive, total) async {
    double _progress = await   total / receive;
    print("progress $receive  /  $total");
    setState(() {
      progress = _progress;
      print("progress ${_progress}");
    });
  }

  _launchURL(pageUrl) async {
    final uri = Uri.parse(pageUrl);
    print(pageUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $pageUrl';
    }
  }
}
