import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/market_page/market_page.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/pullmoney_controller.dart';
import '../../global_widgets/ktextformfield.dart';

class PullMoneyPage extends GetView<PullMoneyController> {
  const PullMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // Papara Part
                  Padding(
                    padding: PaddingUtility().defaultCardPadding,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/images/papara.png",
                            width: 104.w,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '30 TL çekim limiti: ',
                                style: GoogleFonts.archivo(color: ColorManager.instance.black, fontSize: 17),
                              ),
                              Text(
                                ' 3000',
                                style: GoogleFonts.archivo(color: ColorManager.instance.black, fontSize: 17),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0.w),
                                child: Image.asset(
                                  "assets/images/bills.png",
                                  width: 18,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                            child: KTextFormField.instance.widget(
                              context: context,
                              labelText: "Papara Numaranı Gir",
                              maxLines: 1,
                              controller: c.paparaController,
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
                              if (c.paparaController.text.isEmpty) {
                                Get.closeAllSnackbars();
                                Get.snackbar("Hoop!", "Önce Numaranı Girmelisin",
                                    backgroundColor: ColorManager.instance.secondary);
                              } else if (c.userSnapshot?.data()?["money"] >= 3000) {
                                DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .get();
                                int newMoney = c.userSnapshot?.data()?["money"] - 3000;
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {
                                    "money": newMoney,
                                  },
                                );
                                c.getUserInfo();
                                c.update();
                                FirebaseFirestore.instance.collection("paracek").add(
                                  {
                                    "paparaNo": c.paparaController.text,
                                    "status": "Papara-30",
                                    "date": DateTime.now(),
                                    "user": user.data()?["name"] + " " + user.data()?["surname"],
                                    "uidBilgi": user.data()?["uid"],
                                  },
                                ).then(
                                  (value) {
                                    Get.closeAllSnackbars();
                                    Get.snackbar("Başarılı!", "Talep Oluşturuldu",
                                        backgroundColor: ColorManager.instance.snackbarGreen);
                                  },
                                );

                                c.update();
                              } else {
                                Get.closeAllSnackbars();
                                Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                    backgroundColor: ColorManager.instance.secondary);
                              }
                            },
                            child: Container(
                              margin: PaddingUtility().defaultButtonMargin,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: ColorManager.instance.fourth),
                              child: Text(
                                'TALEP OLUŞTUR',
                                style: GoogleFonts.archivo(
                                    color: ColorManager.instance.white, fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Binance Part
                  Padding(
                    padding: PaddingUtility().defaultCardPadding,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/binance.png",
                            width: 124.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '100 TL çekim limiti: ',
                                style: GoogleFonts.archivo(color: ColorManager.instance.black, fontSize: 17),
                              ),
                              Text(
                                ' 10000',
                                style: GoogleFonts.archivo(color: ColorManager.instance.black, fontSize: 17),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0.w),
                                child: Image.asset(
                                  "assets/images/bills.png",
                                  width: 18.w,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                            child: KTextFormField.instance.widget(
                              context: context,
                              labelText: "USDT TRC20 Adresini Gir",
                              maxLines: 1,
                              controller: c.usdtController,
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
                              if (c.usdtController.text.isEmpty) {
                                Get.closeAllSnackbars();
                                Get.snackbar("Hoop!", "Önce Adresini Girmelisin",
                                    backgroundColor: ColorManager.instance.secondary);
                              } else if (c.userSnapshot?.data()?["money"] >= 10000) {
                                DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .get();
                                int newMoney = c.userSnapshot?.data()?["money"] - 10000;
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {
                                    "money": newMoney,
                                  },
                                );
                                c.getUserInfo();
                                c.update();
                                FirebaseFirestore.instance.collection("paracek").add(
                                  {
                                    "usdtNumara": c.usdtController.text,
                                    "status": "USDT-TRC20-100",
                                    "date": DateTime.now(),
                                    "user": user.data()?["name"] + " " + user.data()?["surname"],
                                    "uidBilgi": user.data()?["uid"],
                                  },
                                ).then((value) {
                                  Get.closeAllSnackbars();
                                  Get.snackbar(
                                    "Başarılı!",
                                    "Talep Oluşturuldu",
                                    backgroundColor: ColorManager.instance.snackbarGreen,
                                  );
                                });

                                c.update();
                              } else {
                                Get.closeAllSnackbars();
                                Get.snackbar("Hoop!", "Bu Ürünü Almak İçin Bakiyen Yeterli Değil",
                                    backgroundColor: ColorManager.instance.secondary);
                              }
                            },
                            child: Container(
                              margin: PaddingUtility().defaultButtonMargin,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: ColorManager.instance.fourth),
                              child: Text(
                                'TALEP OLUŞTUR',
                                style: GoogleFonts.archivo(
                                    color: ColorManager.instance.white, fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
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
  }
}
