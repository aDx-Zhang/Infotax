import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Screen/Services/components/CardDesign.dart';
import 'package:info_tax_square/Utils/AppData.dart';
import 'package:info_tax_square/Utils/SearchFeild.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({Key? key}) : super(key: key);
  var controller = Get.put(ApiController());
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchField(
            controller: textController,
            onChange: (value) {
              controller.getFilteredAllServices(value);
            },
          ),
          Expanded(
            child: GetBuilder<ApiController>(builder: (controller) {
              return controller.isServicesLoaded.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: textController.text.isEmpty
                              ? controller.allServices.length
                              : controller.filterAllServices.length,
                          itemBuilder: (context, index) {
                            var service =  textController.text.isEmpty
                                ? controller.allServices[index]
                                : controller.filterAllServices[index];
                            return CardDesign(
                              title: service.csTitle,
                              url: service.csPageUrl,
                              onTap: () async {
                                await _launchURL(service.csPageUrl);
                              },
                            );
                          }),
                    );
            }),
          )
        ],
      ),
    );
  }

  _launchURL(pageUrl) async {
    var url = "https://www." + AppData.WEB_URL + "/" + pageUrl + ".php".trim();
    final uri = Uri.parse(url);
    print(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
