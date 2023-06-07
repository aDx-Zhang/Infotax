

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Model/SecretaryStateDetail.dart';
import 'package:info_tax_square/Utils/BottomSendInquiryButton.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class SecretaryStatesDetailScreen extends StatefulWidget {
  SecretaryStatesDetailScreen({Key? key, this.state_id, this.title}) : super(key: key);
  var state_id;
  var title;
  @override
  State<SecretaryStatesDetailScreen> createState() => _SecretaryStatesDetailScreenState();
}

class _SecretaryStatesDetailScreenState extends State<SecretaryStatesDetailScreen> {
  late SecretaryStateDetail secretaryStateDetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.colorBackground, size: 22,),
        ),
        title: Text(widget.title ?? "", style: TextStyle(color: AppColors.colorBackground, fontSize: 22),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<SecretaryStateDetail>(
                future: getStatesDetail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            secretaryStateDetail.ssTitle,
                            style: TextStyle(
                                color: AppColors.colorSecondary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          Html(data: secretaryStateDetail.fnStripTagsSsPageContent)
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomSendInquiryButton(
        // onTap: (){},
        text: "Inquiry",
      ),
    );
  }

  Future<SecretaryStateDetail> getStatesDetail() async{
    try{
     var response = await Api().getSecretaryStateDetail(state_id: widget.state_id);
     var data = jsonDecode(response);
     if(data["status"]){
       secretaryStateDetail = SecretaryStateDetail.fromJson(data["data"][0]);
     }
    }
    catch(e){
      print(e);
    }
    finally{}
    return secretaryStateDetail;
  }
  @override
  void initState() {
    super.initState();
    getStatesDetail();

  }
}
