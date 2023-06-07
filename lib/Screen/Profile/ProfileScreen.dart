import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Model/UserProfile.dart';
import 'package:info_tax_square/Screen/Profile/EditProfileScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
      ),
      body: GetBuilder<ApiController>(
        builder: (controller) {
          return !controller.isProfileLoaded.value
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CachedNetworkImage(
                        imageUrl: "http://via.placeholder.com/",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/edit_profile_pic.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/edit_profile_pic.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.userProfile.value.firstname! + " " + controller.userProfile.value.lastname! ,
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(controller.userProfile.value.secEmail ?? "abc@mail.com",
                          style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.7),
                              fontSize: 18)),
                      const SizedBox(height: 25),
                      profileTile(
                          key: "Company Name",
                          value: controller.userProfile.value.companyname ?? "company name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "Mailing Address",
                          value: controller.userProfile.value.address ?? "address name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "City",
                          value: controller.userProfile.value.city ?? "city name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "State",
                          value: controller.userProfile.value.state ?? "state name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "Zip",
                          value: controller.userProfile.value.zipcode ?? "zipcode name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "Phone",
                          value: controller.userProfile.value.phone ?? "phone name not defined",
                          onClick: () {}),
                      profileTile(
                          key: "Faxes",
                          value: controller.userProfile.value.fax ?? "fax name not defined",
                          onClick: () {}),
                      const SizedBox(height: 30),

                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorSecondary,
                      ),
                    ),
                  ],
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: AppColors.alterColor,
                backgroundColor: AppColors.alterColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        userProfile:
                        controller.userProfile.value,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  profileTile({key, value, onClick}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                key,
                style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w200),
              )),
          Expanded(
              flex: 1,
              child: Text(
                value,
                style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              )),
        ],
      ),
    );
  }
}
