import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/market_page/market_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/mining_page/mining_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/wheel_page/wheel_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../global_widgets/admob.dart';
import '../chest_page/chest_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: ColorManager.instance.primary,
          bottomNavigationBar: SizedBox(
              height: 50, width: Get.width, child: const BannerAdmob()),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20.w, bottom: 50.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HourlyButton(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GestureDetector(
                      onTap: () {
                        if (c.userSnapshot?.data()?["healt"] > 0) {
                          int newHealt = c.userSnapshot?.data()?["healt"] - 1;
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update(
                            {
                              "healt": newHealt,
                            },
                          );
                          c.getUserInfo();
                          c.update();
                          Get.to(() => WheelPage());
                        } else {
                          Get.closeAllSnackbars();
                          Get.snackbar(
                              "Hoop!", "Oynamak İçin Canın Yeterli Değil",
                              backgroundColor: ColorManager.instance.secondary);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.instance.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/roulette.png",
                              width: 80.w,
                            ),
                           
                            Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Çark Çevir ve Ödülünü Kazan',
                                      style: TextStyle(fontSize: 12.5.r)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Fiyat: '),
                                        Image.asset(
                                          "assets/images/heart.png",
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Min Ödül: '),
                                        Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Max Ödül: '),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.w),
                    child: GestureDetector(
                      onTap: () {
                        if (c.userSnapshot?.data()?["healt"] >= 2) {
                          int newHealt = c.userSnapshot?.data()?["healt"] - 2;
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update(
                            {
                              "healt": newHealt,
                            },
                          );
                          c.getUserInfo();
                          c.update();
                          Get.to(() => ChestPage());
                        } else {
                          Get.closeAllSnackbars();
                          Get.snackbar(
                              "Hoop!", "Oynamak İçin Canın Yeterli Değil",
                              backgroundColor: ColorManager.instance.secondary);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.instance.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/chest.png",
                              width: 80.w,
                            ),
                           
                            Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Reklam İzleyerek Sandık Aç',
                                      style: TextStyle(fontSize: 12.5.r)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Fiyat: '),
                                        Image.asset(
                                          "assets/images/heart.png",
                                          width: 18.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.0.w),
                                          child: Image.asset(
                                            "assets/images/heart.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Min Ödül: '),
                                        Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.0.w),
                                          child: Image.asset(
                                            "assets/images/bills.png",
                                            width: 18.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Max Ödül: '),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: GestureDetector(
                      onTap: () {
                        if (c.userSnapshot?.data()?["healt"] > 0) {
                          int newHealt = c.userSnapshot?.data()?["healt"] - 1;
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update(
                            {
                              "healt": newHealt,
                            },
                          );
                          c.getUserInfo();
                          c.update();
                          Get.to(() => const MiningPage());
                        } else {
                          Get.closeAllSnackbars();
                          Get.snackbar(
                              "Hoop!", "Oynamak İçin Canın Yeterli Değil",
                              backgroundColor: ColorManager.instance.secondary);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.instance.secondary,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/mining.png",
                              width: 80.w,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Reklam İzleyerek Maden Kaz',
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 12.5.r)),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Fiyat: '),
                                        Image.asset(
                                          "assets/images/heart.png",
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Min Ödül: '),
                                        Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Max Ödül: '),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0.w),
                                        child: Image.asset(
                                          "assets/images/bills.png",
                                          width: 18.w,
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/bills.png",
                                        width: 18.w,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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

class HourlyButton extends StatefulWidget {
  @override
  _HourlyButtonState createState() => _HourlyButtonState();
}

var c;

class _HourlyButtonState extends State<HourlyButton> {
  Future<void> _saveLastClickedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastClickedTime', currentTime);
  }

  Future<void> _handleButtonClick() async {
    final prefs = await SharedPreferences.getInstance();
    final lastClickedTime = prefs.getInt('lastClickedTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (lastClickedTime != null &&
        currentTime - lastClickedTime < 24 * 60 * 60 * 1000) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Hata'),
                content:
                    Text('24 saat içinde sadece bir kez tıklama izniniz var.'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Tamam'),
                  ),
                ],
              ));
    } else {
      await _saveLastClickedTime();
      showDialog(
          context: context,
          builder: (context) => GetBuilder<HomeController>(
                builder: (c) {
                  return AlertDialog(
                      content: ElevatedButton(
                          onPressed: () {
                            int newMoney =
                                c.userSnapshot?.data()?["money"] + (5);
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update(
                              {
                                "money": newMoney,
                              },
                            );
                            c.getUserInfo();
                            // c.showRewardedAdGames();
                            Get.back();
                          },
                          child: Text("Para İçin Tıkla")));
                },
              ));
      print("Kazandın len");
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isActive = DateTime.now().millisecondsSinceEpoch - lastClick > 24 * 60 * 60 * 1000;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
      child: GestureDetector(
        onTap: _handleButtonClick,
        child: Container(
          margin: PaddingUtility().defaultButtonMargin,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              color: ColorManager.instance.secondary,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/money.png",
                width: 80.w,
              ),
              Text(
                "Reklam İzleyerek Günlük para ödülünü al...",
                style: TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
