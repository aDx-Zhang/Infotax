import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Screen/SecretaryStates/SecretaryStatesDetailScreen.dart';
import 'package:info_tax_square/Screen/SecretaryStates/components/StateCardDesign.dart';
import 'package:info_tax_square/Screen/Services/components/CardDesign.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/Utils/SearchFeild.dart';

class SecretaryStatesScreen extends StatelessWidget {
  SecretaryStatesScreen({Key? key}) : super(key: key);
  var controller = Get.put(ApiController());
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: IconButton(
                      onPressed: () {
                        homeController.setIndex(4);
                        homeController.setAppBarText("Home");
                      },
                      icon: Icon(
                        Icons.undo,
                        color: AppColors.colorBackground,
                      )),
                ),
                Expanded(
                  child: SearchField(
                    onEditingComplete: () {},
                    onChange: (value) {
                      controller.getFilteredSecretaryStated(value);
                    },
                    controller: searchController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GetBuilder<ApiController>(builder: (controller) {
                return controller.isSecretaryStatesLoaded.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.colorSecondary,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 20,
                                    width: 3,
                                    child: Container(
                                        color: AppColors.colorSecondary),
                                  ),
                                  SizedBox(width: 3),
                                  SizedBox(
                                    height: 20,
                                    width: 3,
                                    child: Container(
                                        color: AppColors.colorSecondary),
                                  ),
                                ],
                              );
                            },
                            scrollDirection: Axis.vertical,
                            itemCount:
                            searchController.text.isEmpty
                                    ? controller.secretaryStates.length
                                    : controller.filteredSecretaryStates.length,
                            itemBuilder: (context, index) {
                              var secretaryState = searchController.text.isEmpty
                                  ? controller.secretaryStates[index]
                                  : controller.filteredSecretaryStates[index];
                              return StateCardDesign(
                                title: secretaryState.stname,
                                titleId: secretaryState.stateId,
                                totalServices: secretaryState.totalServices,
                                url: secretaryState.ssPageUrl,
                                onTap: () {
                                  Get.to(() => SecretaryStatesDetailScreen(
                                        title: secretaryState.stname,
                                        state_id: secretaryState.stateId,
                                      ));
                                },
                              );
                            }),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
