import 'package:flutter/material.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Utils/AppData.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! * 0.18,
              height: SizeConfig.screenWidth! * 0.18,
              child: Image.asset(
                "assets/logos/logo@2x.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(

                    child: Text("R", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                      )
                    ),
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                  )
                ],
              ),
            ),
            Text(
              AppData.WEB_URL,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(
                color: Colors.red,
                thickness: 3,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
            Text(
              AppData.LICENSES_AND_PERMIT,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.03,
            ),
            Row(
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(
                      color: AppColors.colorSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.03,
            ),
            buildAboutUsTile(Icons.contact_support, AppData.EMAIL, () {
              UrlLauncher.launchUrl(Uri(
                scheme: 'mailto',
                path: AppData.EMAIL,
                query: 'subject=Hello&body=Test',
              ));
            }),
            buildAboutUsTile(Icons.home, AppData.ADDRESS, () async{
              String query = Uri.encodeComponent(AppData.ADDRESS);
              String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
              if (await UrlLauncher.canLaunchUrl(Uri.parse(googleUrl))) {
                await UrlLauncher.launchUrl(Uri.parse(googleUrl));
              }
             // UrlLauncher.launchUrl(Uri.parse(AppData.ADDRESS));
            }),
            buildAboutUsTile(Icons.phone, AppData.PHONE_NO, () {
              UrlLauncher.launchUrl(Uri.parse("tel:${AppData.PHONE_NO}"));
            }),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.05,
            ),
            Row(
              children: [
                Text(
                  "Call Us Free",
                  style: TextStyle(
                      color: AppColors.colorSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ],
            ),
            buildAboutUsTile(Icons.contact_support, AppData.PHONE_NO_FREE, () {
              UrlLauncher.launchUrl(Uri.parse("tel:${AppData.PHONE_NO_FREE}"));
            }),
          ],
        ),
      ),
    );
  }

  buildAboutUsTile(icon, text, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      onLongPress: onTap,
      leading: Icon(
        icon,
        color: AppColors.colorSecondary,
      ),
      title: Text(
        text,
        style: TextStyle(color: AppColors.textColor, fontSize: 18),
      ),
    );
  }
}
