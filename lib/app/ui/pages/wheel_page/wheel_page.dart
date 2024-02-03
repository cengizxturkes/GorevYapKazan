import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/wheel_controller.dart';
import '../../utils/dialog.dart';

class WheelPage extends GetView<WheelController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c1) {
      return Scaffold(
          body: Scaffold(
        backgroundColor: ColorManager.instance.third,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: GetBuilder<WheelController>(
              builder: (c) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.height / 2.8,
                        child: FortuneWheel(
                          indicators: [
                            FortuneIndicator(
                              alignment: Alignment.bottomCenter,
                              child: TriangleIndicator(
                                color: ColorManager.instance.third,
                              ),
                            ),
                          ],
                          duration: Duration(seconds: 5),
                          physics: CircularPanPhysics(
                            duration: const Duration(seconds: 1),
                            curve: Curves.decelerate,
                          ),
                          animateFirst: false,
                          rotationCount: 30,
                          onAnimationStart: () {
                            c.isClicked = false;
                            c.update();
                            debugPrint('Start');
                          },
                          onAnimationEnd: () {
                            debugPrint('Finish');

                            c.isClicked = true;

                            c.update();
                          },
                          selected: c.controller.stream,
                          items: [
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('1',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin1,
                                    borderWidth: 0)),
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('2',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin2,
                                    borderWidth: 0)),
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('3',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin3,
                                    borderWidth: 0)),
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('1',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin4,
                                    borderWidth: 0)),
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('2',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin5,
                                    borderWidth: 0)),
                            FortuneItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('3',
                                        style: GoogleFonts.archivoBlack(
                                            fontSize: 20)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Image.asset(
                                          "assets/images/bills.png"),
                                    ),
                                  ],
                                ),
                                style: FortuneItemStyle(
                                    color: ColorManager.instance.spin6,
                                    borderWidth: 0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0.h),
                        child: GestureDetector(
                          onTap: () {
                            if (c.isClicked) {
                              Random random = Random();

                              int randomNumberFirst = random.nextInt(5) + 1;
                              int randomNumber = 0;
                              if (randomNumberFirst == 1) {
                                randomNumber = 2;
                              } else if (randomNumberFirst == 2) {
                                randomNumber = 3;
                              } else if (randomNumberFirst == 3) {
                                randomNumber = 1;
                              } else if (randomNumberFirst == 4) {
                                randomNumber = 2;
                              } else if (randomNumberFirst == 5) {
                                randomNumber = 3;
                              } else {
                                randomNumber = 1;
                              }
                              c.controller.add(
                                randomNumberFirst,
                              );
                              Future.delayed(
                                Duration(seconds: 5),
                                () => KaracaUtils()
                                    .showGeneralDialog(
                                  context,
                                  dismissible: false,
                                  body: Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              randomNumber.toString(),
                                              style: TextStyle(
                                                  color: ColorManager
                                                      .instance.fourth,
                                                  fontSize: 21),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0),
                                              child: Image.asset(
                                                  "assets/images/bills.png"),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: InkWell(
                                            onTap: () {
                                              c1.showRewardedAdGames(() {
                                                int newMoney = c1.userSnapshot
                                                        ?.data()?["money"] +
                                                    randomNumber;
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .update(
                                                  {
                                                    "money": newMoney,
                                                  },
                                                );
                                                c1.getUserInfo();
                                              });
                                              Get.back();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: ColorManager
                                                        .instance.fourth,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  color: ColorManager
                                                      .instance.third),
                                              child: Text(
                                                  'REKLAM İZLE ÖDÜLÜ AL',
                                                  style: GoogleFonts.archivo(
                                                      color: ColorManager
                                                          .instance.fourth,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                                    .then((e) {
                                  Get.back();
                                }),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorManager.instance.fourth,
                                boxShadow: kElevationToShadow[2]),
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 50.h),
                            child: Text(
                              "ÇEVİR",
                              style: TextStyle(
                                  color: ColorManager.instance.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ));
    });
  }
}
