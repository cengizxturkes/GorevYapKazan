import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/mining_controller.dart';
import '../../global_widgets/multiple_tap.dart';
import '../../utils/dialog.dart';

class MiningPage extends GetView<MiningController> {
  const MiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Scaffold(
        backgroundColor: ColorManager.instance.third,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppMultipleTap(
                onMultipleTap: () {
                  Random random = Random();
                  int randomNumber = random.nextInt(2) + 1;
                  KaracaUtils()
                      .showGeneralDialog(
                    context,
                    dismissible: false,
                    body: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                randomNumber.toString(),
                                style: TextStyle(
                                    color: ColorManager.instance.fourth,
                                    fontSize: 21),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Image.asset("assets/images/bills.png"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: InkWell(
                              onTap: () {
                                int newMoney =
                                    c.userSnapshot?.data()?["money"] +
                                        randomNumber;
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update(
                                  {
                                    "money": newMoney,
                                  },
                                );
                                c.getUserInfo();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Reklam İzle"),
                                      content: Text(
                                          "Reklamı izleyerek ödül kazanabilirsiniz."),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await c.showRewardedAdGames();
                                          },
                                          child: Text("İzle"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Kapat"),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.instance.fourth,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: ColorManager.instance.third),
                                child: Text('REKLAM İZLE ÖDÜLÜ AL',
                                    style: GoogleFonts.archivo(
                                        color: ColorManager.instance.fourth,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                      .then((e) {
                    Get.back();
                  });
                },
                child: Image.asset("assets/images/rock.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text('Kayaya Art Arda Dokun ve Ödülünü Topla',
                    style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      );
    });
  }
}
