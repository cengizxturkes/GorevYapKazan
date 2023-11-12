import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/init/theme/color_manager.dart';

class DynamicLinkProvider {
  Future<String> creatinLink(String refCode) async {
    final String url =
        "https://mozpara.page.link/?link=https://play.google.com/store/apps/details?id%3Dcom.mozpara.reklamizle&apn=com.mozpara.reklamizle$refCode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters: AndroidParameters(packageName: "moz-para", minimumVersion: 0),
      iosParameters: IOSParameters(bundleId: "moz-para", minimumVersion: "0"),
      link: Uri.parse(url),
      uriPrefix: "https://mozpara.page.link",
    );
    final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final istanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (istanceLink != null) {
      final Uri refLink = istanceLink.link;
      Clipboard.setData(ClipboardData(
        text: "this is link : ${refLink.data}",
      ));
    }
  }
}

void callreflink() {
  DynamicLinkProvider().creatinLink("ib87").then(
    (value) async {
      Clipboard.setData(ClipboardData(text: value));
      Get.snackbar("Başarılı!", "Referans Kodunuz Kopyalandı", backgroundColor: ColorManager.instance.secondary);
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "ref": value,
      });
    },
  );
}
