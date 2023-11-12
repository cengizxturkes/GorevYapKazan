import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/global_widgets/ktextformfield.dart';
import 'package:gorev_yap_kazan_app/app/ui/utils/dynamicLink.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/share_controller.dart';

class SharePage extends GetView<ShareController> {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareController>(
      init: ShareController(),
      builder: (c1) {
        return GetBuilder<HomeController>(
          builder: (c) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 24.w),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/share.png",
                                width: 104.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.w),
                                      child: Text(
                                        'Arkadaşını Davet Et, Hem Sen 30 Para Kazan, Hem Arkadaşın 30 Para Kazansın Ekstra sen de %10 kazan ',
                                        style: GoogleFonts.archivo(fontSize: 15, color: ColorManager.instance.third),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                      child: Text(
                                        'Referans Kodun :',
                                        style: GoogleFonts.archivo(fontSize: 15, color: ColorManager.instance.third),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            Clipboard.setData(
                                                    ClipboardData(text: FirebaseAuth.instance.currentUser!.uid))
                                                .then((value) {
                                              Get.closeAllSnackbars();
                                              Get.snackbar("Başarılı!", "Referans Kodunuz Kopyalandı",
                                                  backgroundColor: ColorManager.instance.secondary);
                                            });
                                          },
                                          child: Text(
                                            'Kopyala',
                                            style: TextStyle(color: ColorManager.instance.fourth),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 24.w),
                        child: Card(
                          elevation: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                child: KTextFormField.instance.widget(
                                  context: context,
                                  controller: c1.refController,
                                  labelText: "Referans Kodunu Gir",
                                  maxLines: 1,
                                  validation: (val) {
                                    if (val!.isEmpty) {
                                      return "Lütfen bu alanı doldurunuz.";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (c1.refController.text.isEmpty) {
                                    Get.snackbar("Hoop!", "Referans Kodun Boş",
                                        backgroundColor: ColorManager.instance.secondary);
                                  } else if (c1.refController.text != "https://mozpara.page.link/QYkB") {
                                    DocumentSnapshot<Map<String, dynamic>> used = await FirebaseFirestore.instance
                                        .collection("used")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .get();
                                    if (used.data()?["used"] == true || used.data()?["used"] != null) {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Hesapta Referans Kodu Kullanmışsın");
                                    } else {
                                      DocumentSnapshot<Map<String, dynamic>> varMi = await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(c1.refController.text)
                                          .get();

                                      if (varMi.data()?["uid"] != null) {
                                        QuerySnapshot<Map<String, dynamic>> me = await FirebaseFirestore.instance
                                            .collection("users")
                                            .where("uid", isEqualTo: c1.refController.text)
                                            .get();
                                        if (me.docs.isNotEmpty) {
                                          int newMoney = c.userSnapshot?.data()?["money"] + (30 + (10));
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .update(
                                            {
                                              "money": newMoney,
                                            },
                                          );
                                          var otherUser = await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(c1.refController.text)
                                              .get();
                                          int newPrice = otherUser.data()?["money"] + 30;
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(c1.refController.text)
                                              .update(
                                            {
                                              "money": newPrice,
                                            },
                                          );
                                          FirebaseFirestore.instance
                                              .collection("used")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .set(
                                            {
                                              "used": true,
                                            },
                                          );
                                          c.getUserInfo();
                                          Get.closeAllSnackbars();

                                          Get.snackbar("Başarılı!", "Bakiyen Sana ve Arkadaşına Eklendi",
                                              backgroundColor: ColorManager.instance.snackbarGreen);
                                          c.update();
                                          print(" looooo ${otherUser.metadata}");
                                        }
                                      } else {
                                        Get.closeAllSnackbars();
                                        Get.snackbar("Hoop!", "Böyle Bir Ref Kodu Yok",
                                            backgroundColor: ColorManager.instance.secondary);
                                      }
                                    }
                                  } else {
                                    Get.closeAllSnackbars();
                                    Get.snackbar("Hoop!", "Kendi Kodunu Kullanamazsın",
                                        backgroundColor: ColorManager.instance.secondary);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: ColorManager.instance.fourth),
                                  child: Text(
                                    'REFERANS KODUNU GİR',
                                    style: GoogleFonts.archivo(
                                        color: ColorManager.instance.white, fontSize: 17, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
