import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/utils/dialog.dart';
import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/chest_controller.dart';

class ChestPage extends GetView<ChestController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Scaffold(
        backgroundColor: ColorManager.instance.third,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Random random = Random();
                  int randomNumber = random.nextInt(5) + 2;
                  print(randomNumber);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Sandık Ödülü"),
                        content: Container(
                          height: 150,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    randomNumber.toString(),
                                    style: TextStyle(
                                      color: ColorManager.instance.fourth,
                                      fontSize: 21,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child:
                                        Image.asset("assets/images/bills.png"),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: GestureDetector(
                                  onTap: () {
                                     c.userSnapshot?.data()?["healt"] - 2;
                                    int newMoney =
                                        c.userSnapshot?.data()?["money"] +
                                            randomNumber;
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "money": newMoney,
                                    });
                                    c.getUserInfo();

                                    Navigator.of(context).pop();
                                  },
                                  child: GestureDetector(
                                      onTap: () async{
                                        print("TIklandı");
                                       await c.showRewardedAdGames();
                                         int newMoney =
                                        c.userSnapshot?.data()?["money"] +
                                            randomNumber;
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      "money": newMoney,
                                    });
                                    c.getUserInfo();
                                        Navigator.of(context).pop();
                                      },
                                      child: Center(child: Text("Al"))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/chest_close.png"),
                    Image.asset("assets/images/chest_close.png"),
                    Image.asset("assets/images/chest_close.png"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'Reklam İzleyerek Bir Sandık Seç ve Ödülünü Al',
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorManager.instance.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
