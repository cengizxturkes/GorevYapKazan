import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/global_widgets/ktextformfield.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/market_controller.dart';
import '../../utils/dialog.dart';

class PaddingUtility {
  EdgeInsets defaultCardPadding = EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.w);
  EdgeInsets defaultButtonPadding = EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.w);
  EdgeInsets defaultButtonMargin = EdgeInsets.all(8.w);
}

class MarketPage extends GetView<MarketController> {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c1) {
        return Scaffold(
          body: GetBuilder<MarketController>(
            builder: (c) {
              return SingleChildScrollView(
                child: Padding(
                  padding: PaddingUtility().defaultCardPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Hattına 50 Tl
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                  "assets/images/phone.png",
                                  width: 50.w,
                                ),
                                title: Text('Hattına 50 TL'),
                                subtitle: Text(
                                  'Telefon hattına 50 TL bakiye',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (c1.userSnapshot?.data()?["money"] >= 5000) {
                                        KaracaUtils().showGeneralDialog(
                                          context,
                                          body: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                  child: KTextFormField.instance.widget(
                                                    context: context,
                                                    controller: c1.phoneNumberController,
                                                    labelText: "Telefon Numaran",
                                                    maxLines: 1,
                                                    validation: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Lütfen bu alanı doldurunuz.";
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.w),
                                                  child: KTextFormField.instance.widget(
                                                    context: context,
                                                    controller: c1.operatorController,
                                                    labelText: "Telefon Operatörün",
                                                    maxLines: 1,
                                                    validation: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Lütfen bu alanı doldurunuz.";
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 12.0.w),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (c1.phoneNumberController.text.isEmpty &&
                                                          c1.operatorController.text.isEmpty) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar(
                                                            "Hoop!", "Telefon Numaran ve Operatörün Boş Olamaz",
                                                            backgroundColor: ColorManager.instance.secondary);
                                                      } else {
                                                        DocumentSnapshot<Map<String, dynamic>> user =
                                                            await FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                .get();
                                                        int newMoney = c1.userSnapshot?.data()?["money"] - 5000;
                                                        FirebaseFirestore.instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .update(
                                                          {
                                                            "money": newMoney,
                                                          },
                                                        );
                                                        c1.getUserInfo();
                                                        c1.update();
                                                        FirebaseFirestore.instance.collection("telbakiye").add(
                                                          {
                                                            "phone": c1.phoneNumberController.text,
                                                            "operator": c1.operatorController.text,
                                                            "status": "telbakiye-50",
                                                            "user":
                                                                user.data()?["name"] + " " + user.data()?["surname"],
                                                            "uidBilgi": user.data()?["uid"],
                                                            "date": DateTime.now(),
                                                          },
                                                        ).then((value) {
                                                          Get.closeAllSnackbars();
                                                          Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                              backgroundColor: ColorManager.instance.snackbarGreen);
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: ColorManager.instance.fourth,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: ColorManager.instance.third),
                                                      child: Text('TALEP GÖNDER',
                                                          style: GoogleFonts.archivo(
                                                              color: ColorManager.instance.fourth,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        c1.update();
                                        c.update();
                                      } else {
                                        Get.closeAllSnackbars();
                                        Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                            backgroundColor: ColorManager.instance.secondary);
                                      }
                                    },
                                    child: Container(
                                      margin: PaddingUtility().defaultButtonMargin,
                                      padding: PaddingUtility().defaultButtonPadding,
                                      decoration: BoxDecoration(
                                          color: ColorManager.instance.third,
                                          border: Border.all(
                                            color: ColorManager.instance.third,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('5000'),
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0.w),
                                            child: Image.asset(
                                              "assets/images/bills.png",
                                              width: 18.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // PlayStore 25 Tl
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            elevation: 1,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/market/playStore.png",
                                    width: 50.w,
                                  ),
                                  title: Text('PlayStore 25 TL'),
                                  subtitle: Text(
                                    'Google Play 25 TL redeem code',
                                    style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (c1.userSnapshot?.data()?["money"] >= 2500) {
                                          KaracaUtils().showGeneralDialog(
                                            context,
                                            body: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.w),
                                                    child: KTextFormField.instance.widget(
                                                      context: context,
                                                      controller: c1.emailController,
                                                      labelText: "E-posta",
                                                      maxLines: 1,
                                                      validation: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Lütfen bu alanı doldurunuz.";
                                                        }

                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 12.0.w),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (c1.emailController.text.isEmpty) {
                                                          Get.closeAllSnackbars();
                                                          Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                              backgroundColor: ColorManager.instance.secondary);
                                                        } else {
                                                          DocumentSnapshot<Map<String, dynamic>> user =
                                                              await FirebaseFirestore.instance
                                                                  .collection("users")
                                                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                  .get();
                                                          int newMoney = c1.userSnapshot?.data()?["money"] - 2500;
                                                          FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .update(
                                                            {
                                                              "money": newMoney,
                                                            },
                                                          );
                                                          c1.getUserInfo();
                                                          c1.update();
                                                          FirebaseFirestore.instance.collection("market").add(
                                                            {
                                                              "email": c1.emailController.text,
                                                              "status": "playstore-25",
                                                              "user":
                                                                  user.data()?["name"] + " " + user.data()?["surname"],
                                                              "uidBilgi": user.data()?["uid"],
                                                              "date": DateTime.now(),
                                                            },
                                                          ).then((value) {
                                                            Get.closeAllSnackbars();
                                                            Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                                backgroundColor: ColorManager.instance.snackbarGreen);
                                                          });
                                                          Get.back();
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(8.w),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: ColorManager.instance.fourth,
                                                            ),
                                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                                            color: ColorManager.instance.third),
                                                        child: Text('TALEP GÖNDER',
                                                            style: GoogleFonts.archivo(
                                                                color: ColorManager.instance.fourth,
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w600)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                          c1.update();
                                          c.update();
                                        } else {
                                          Get.closeAllSnackbars();
                                          Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                              backgroundColor: ColorManager.instance.secondary);
                                        }
                                      },
                                      child: Container(
                                        margin: PaddingUtility().defaultButtonMargin,
                                        padding: PaddingUtility().defaultButtonPadding,
                                        decoration: BoxDecoration(
                                            color: ColorManager.instance.third,
                                            border: Border.all(
                                              color: ColorManager.instance.third,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('2500'),
                                            Padding(
                                              padding: EdgeInsets.only(left: 6.0.w),
                                              child: Image.asset(
                                                "assets/images/bills.png",
                                                width: 18.w,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      // Play Store 50 Tl
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset("assets/images/market/playStore.png", width: 50.w),
                                title: Text('PlayStore 50 TL'),
                                subtitle: Text(
                                  'Google Play 50 TL redeem code',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (c1.userSnapshot?.data()?["money"] >= 5000) {
                                        KaracaUtils().showGeneralDialog(
                                          context,
                                          body: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.w),
                                                  child: KTextFormField.instance.widget(
                                                    context: context,
                                                    controller: c1.emailController,
                                                    labelText: "E-posta",
                                                    maxLines: 1,
                                                    validation: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Lütfen bu alanı doldurunuz.";
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 12.0.w),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (c1.emailController.text.isEmpty) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                            backgroundColor: ColorManager.instance.secondary);
                                                      } else {
                                                        DocumentSnapshot<Map<String, dynamic>> user =
                                                            await FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                .get();
                                                        int newMoney = c1.userSnapshot?.data()?["money"] - 5000;
                                                        FirebaseFirestore.instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .update(
                                                          {
                                                            "money": newMoney,
                                                          },
                                                        );
                                                        c1.getUserInfo();
                                                        c1.update();
                                                        FirebaseFirestore.instance.collection("market").add(
                                                          {
                                                            "email": c1.emailController.text,
                                                            "user":
                                                                user.data()?["name"] + " " + user.data()?["surname"],
                                                            "uidBilgi": user.data()?["uid"],
                                                            "status": "playstore-50",
                                                            "date": DateTime.now(),
                                                          },
                                                        ).then((value) {
                                                          Get.closeAllSnackbars();
                                                          Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                              backgroundColor: ColorManager.instance.snackbarGreen);
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: ColorManager.instance.fourth,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: ColorManager.instance.third),
                                                      child: Text('TALEP GÖNDER',
                                                          style: GoogleFonts.archivo(
                                                              color: ColorManager.instance.fourth,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        c1.update();
                                        c.update();
                                      } else {
                                        Get.closeAllSnackbars();
                                        Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                            backgroundColor: ColorManager.instance.secondary);
                                      }
                                    },
                                    child: Container(
                                      margin: PaddingUtility().defaultButtonMargin,
                                      padding: PaddingUtility().defaultButtonPadding,
                                      decoration: BoxDecoration(
                                          color: ColorManager.instance.third,
                                          border: Border.all(
                                            color: ColorManager.instance.third,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('5000'),
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0.w),
                                            child: Image.asset(
                                              "assets/images/bills.png",
                                              width: 18.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //Steam 50 Tl
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                "assets/images/market/Steam.png",
                                width: 50.w,
                              ),
                              title: Text('Steam 50 TL'),
                              subtitle: Text(
                                '50 TL Steam kodu',
                                style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 5000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 5000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "steam-50",
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                          "date": DateTime.now(),
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('5000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                      ),
                      // Pubg Mobile 60 UC
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset("assets/images/market/PubGMobile.png", width: 50.w),
                                title: Text('Pubg Mobile 60 UC'),
                                subtitle: Text(
                                  'Pubg Mobile 60 UC',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (c1.userSnapshot?.data()?["money"] >= 1800) {
                                        KaracaUtils().showGeneralDialog(
                                          context,
                                          body: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                  child: KTextFormField.instance.widget(
                                                    context: context,
                                                    controller: c1.emailController,
                                                    labelText: "E-posta",
                                                    maxLines: 1,
                                                    validation: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Lütfen bu alanı doldurunuz.";
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 12.0.w),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (c1.emailController.text.isEmpty) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                            backgroundColor: ColorManager.instance.secondary);
                                                      } else {
                                                        DocumentSnapshot<Map<String, dynamic>> user =
                                                            await FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                .get();
                                                        int newMoney = c1.userSnapshot?.data()?["money"] - 1800;
                                                        FirebaseFirestore.instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .update(
                                                          {
                                                            "money": newMoney,
                                                          },
                                                        );
                                                        c1.getUserInfo();
                                                        c1.update();
                                                        FirebaseFirestore.instance.collection("market").add(
                                                          {
                                                            "email": c1.emailController.text,
                                                            "status": "pubgmobile-60uc",
                                                            "date": DateTime.now(),
                                                            "user":
                                                                user.data()?["name"] + " " + user.data()?["surname"],
                                                            "uidBilgi": user.data()?["uid"],
                                                          },
                                                        ).then((value) {
                                                          Get.closeAllSnackbars();
                                                          Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                              backgroundColor: ColorManager.instance.snackbarGreen);
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: ColorManager.instance.fourth,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: ColorManager.instance.third),
                                                      child: Text('TALEP GÖNDER',
                                                          style: GoogleFonts.archivo(
                                                              color: ColorManager.instance.fourth,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        c1.update();
                                        c.update();
                                      } else {
                                        Get.closeAllSnackbars();
                                        Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                            backgroundColor: ColorManager.instance.secondary);
                                      }
                                    },
                                    child: Container(
                                      margin: PaddingUtility().defaultButtonMargin,
                                      padding: PaddingUtility().defaultButtonPadding,
                                      decoration: BoxDecoration(
                                          color: ColorManager.instance.third,
                                          border: Border.all(
                                            color: ColorManager.instance.third,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('1800'),
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0.w),
                                            child: Image.asset(
                                              "assets/images/bills.png",
                                              width: 18.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Pubg Mobile 325 UC
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset("assets/images/market/PubGMobile.png", width: 50.w),
                                title: Text('Pubg Mobile 325 UC'),
                                subtitle: Text(
                                  'Pubg Mobile 325 UC',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (c1.userSnapshot?.data()?["money"] >= 9000) {
                                        KaracaUtils().showGeneralDialog(
                                          context,
                                          body: Center(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                  child: KTextFormField.instance.widget(
                                                    context: context,
                                                    controller: c1.emailController,
                                                    labelText: "E-posta",
                                                    maxLines: 1,
                                                    validation: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Lütfen bu alanı doldurunuz.";
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 12.0.w),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (c1.emailController.text.isEmpty) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                            backgroundColor: ColorManager.instance.secondary);
                                                      } else {
                                                        DocumentSnapshot<Map<String, dynamic>> user =
                                                            await FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                .get();
                                                        int newMoney = c1.userSnapshot?.data()?["money"] - 9000;
                                                        FirebaseFirestore.instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                                            .update(
                                                          {
                                                            "money": newMoney,
                                                          },
                                                        );
                                                        c1.getUserInfo();
                                                        c1.update();
                                                        FirebaseFirestore.instance.collection("market").add(
                                                          {
                                                            "email": c1.emailController.text,
                                                            "status": "pubgmobile-325uc",
                                                            "date": DateTime.now(),
                                                            "user":
                                                                user.data()?["name"] + " " + user.data()?["surname"],
                                                            "uidBilgi": user.data()?["uid"],
                                                          },
                                                        ).then((value) {
                                                          Get.closeAllSnackbars();
                                                          Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                              backgroundColor: ColorManager.instance.snackbarGreen);
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(8.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: ColorManager.instance.fourth,
                                                          ),
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: ColorManager.instance.third),
                                                      child: Text('TALEP GÖNDER',
                                                          style: GoogleFonts.archivo(
                                                              color: ColorManager.instance.fourth,
                                                              fontSize: 17,
                                                              fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        c1.update();
                                        c.update();
                                      } else {
                                        Get.closeAllSnackbars();
                                        Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                            backgroundColor: ColorManager.instance.secondary);
                                      }
                                    },
                                    child: Container(
                                      margin: PaddingUtility().defaultButtonMargin,
                                      padding: PaddingUtility().defaultButtonPadding,
                                      decoration: BoxDecoration(
                                          color: ColorManager.instance.third,
                                          border: Border.all(
                                            color: ColorManager.instance.third,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20))),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('9000'),
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.0.w),
                                            child: Image.asset(
                                              "assets/images/bills.png",
                                              width: 18.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      //Valorant 175 VP
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/Valorant.png", width: 50.w),
                              title: Text('Valorant 175 VP'),
                              subtitle: Text(
                                'Valorant 175 VP',
                                style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 1500) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 1500;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "valorant-175vp",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('1500'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                      ),
                      //100+10 Free Fire Elmas
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/FreeFire.png", width: 50.w),
                              title: Text('100+10 Free Fire Elmas'),
                              subtitle: Text(
                                '100+10 Free Fire Elmas',
                                style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 2000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 2000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "freefire-100+10",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('2000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      //210+21 Free Fire Elmas
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                "assets/images/market/FreeFire.png",
                                width: 50.w,
                              ),
                              title: Text('210+21 Free Fire Elmas'),
                              subtitle: Text(
                                '210+21 Free Fire Elmas',
                                style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 4000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 4000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "freefire-210+21",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('4000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                      ),
                      //800 Robux
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/Robux.png", width: 50.w),
                              title: Text('800 Robux'),
                              subtitle: Text('800 Robux',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 20000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 20000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "freefire-100+1",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('20.000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      // 850 League Of Legends
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/LoL.png", width: 50.w),
                              title: Text('850 Riot Points'),
                              subtitle: Text('850 Riot Points',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 6500) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 6500;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "riot-points",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('6500'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      // 3000 + 600 Zula
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/Zula.png", width: 50.w),
                              title: Text('3000+600 Zula Altını'),
                              subtitle: Text('3000+600 Zula Altını',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 1600) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 1600;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "zula-altın",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('1600'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      // 10 $ Play store
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/playStore.png", width: 50.w),
                              title: Text('10\$ Play Store Kodu'),
                              subtitle: Text('10\$ Play Store Kodu',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 20000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 20000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "play-store-10-dollar",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('20000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      // 10 $ Steam
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/Steam.png", width: 50.w),
                              title: Text('10\$ Steam Kodu'),
                              subtitle: Text('10\$ Steam Kodu',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 20000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 20000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "steam-10-dollar",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('20000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                      // 5$ Steam Kodu
                      Padding(
                        padding: PaddingUtility().defaultCardPadding,
                        child: Card(
                            child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset("assets/images/market/Steam.png", width: 50.w),
                              title: Text('5\$ Steam Kodu'),
                              subtitle: Text('5\$ Steam Kodu',
                                  style: GoogleFonts.archivo(fontSize: 13, color: ColorManager.instance.third)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (c1.userSnapshot?.data()?["money"] >= 10000) {
                                      KaracaUtils().showGeneralDialog(
                                        context,
                                        body: Center(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.w),
                                                child: KTextFormField.instance.widget(
                                                  context: context,
                                                  controller: c1.emailController,
                                                  labelText: "E-posta",
                                                  maxLines: 1,
                                                  validation: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Lütfen bu alanı doldurunuz.";
                                                    }

                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 12.0.w),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (c1.emailController.text.isEmpty) {
                                                      Get.closeAllSnackbars();
                                                      Get.snackbar("Hoop!", "E-postan Boş Olamaz",
                                                          backgroundColor: ColorManager.instance.secondary);
                                                    } else {
                                                      DocumentSnapshot<Map<String, dynamic>> user =
                                                          await FirebaseFirestore.instance
                                                              .collection("users")
                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                              .get();
                                                      int newMoney = c1.userSnapshot?.data()?["money"] - 10000;
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .update(
                                                        {
                                                          "money": newMoney,
                                                        },
                                                      );
                                                      c1.getUserInfo();
                                                      c1.update();
                                                      FirebaseFirestore.instance.collection("market").add(
                                                        {
                                                          "email": c1.emailController.text,
                                                          "status": "steam-5-dollar",
                                                          "date": DateTime.now(),
                                                          "user": user.data()?["name"] + " " + user.data()?["surname"],
                                                          "uidBilgi": user.data()?["uid"],
                                                        },
                                                      ).then((value) {
                                                        Get.closeAllSnackbars();
                                                        Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                                            backgroundColor: ColorManager.instance.snackbarGreen);
                                                      });
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8.w),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: ColorManager.instance.fourth,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: ColorManager.instance.third),
                                                    child: Text('TALEP GÖNDER',
                                                        style: GoogleFonts.archivo(
                                                            color: ColorManager.instance.fourth,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      c1.update();
                                      c.update();
                                    } else {
                                      Get.closeAllSnackbars();
                                      Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                          backgroundColor: ColorManager.instance.secondary);
                                    }
                                  },
                                  child: Container(
                                    margin: PaddingUtility().defaultButtonMargin,
                                    padding: PaddingUtility().defaultButtonPadding,
                                    decoration: BoxDecoration(
                                        color: ColorManager.instance.third,
                                        border: Border.all(
                                          color: ColorManager.instance.third,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('10000'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 6.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
