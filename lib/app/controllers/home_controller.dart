import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/preferences_keys.dart';
import '../../core/init/cache/cache_manager.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    initRewardedAd();
    getUserInfo();
    watchFunc();
    super.onInit();
  }

  int watch = 0;

  watchFunc() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    watch = sharedPreferences.getInt(key) ?? 0;

    debugPrint("$watch");
    update();
  }

  RewardedAd? rewardedAd;
  var rewardedUnit = 'ca-app-pub-1096844369653763/3924116722'; //testing
  // real ca-app-pub-1096844369653763/8350710222

  initRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedUnit,
      request: AdRequest(
        keywords: [
          "game",
          "roll",
          "health",
        ],
      ),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded');
          rewardedAd = ad;
          update();
          setFullScreen();
        },
        onAdFailedToLoad: (LoadAdError err) {
          print('$err');
        },
      ),
    );
  }

  setFullScreen() {
    if (rewardedAd == null) {
      return;
    }
    rewardedAd?.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (RewardedAd ad) {
      print('$ad onAddShowFullScreenContent');
      rewardedAd = null;
      update();
      initRewardedAd();
    }, onAdDismissedFullScreenContent: (RewardedAd ad) {
      rewardedAd = null;
      print('$ad onAddDismissedFullScreenContent');
      update();
      initRewardedAd();
    }, onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError err) {
      rewardedAd = null;
      print('$ad onAddLoadedFullScreenContent: $err');
      update();
      initRewardedAd();
    }, onAdImpression: (RewardedAd ad) {
      rewardedAd = null;
      update();
      initRewardedAd();
      print("$ad impression occured.");
    });
  }

  DateTime x = DateTime.now();
  String get key => "${x.day}/${x.month}/${x.year}";

  showRewardedAd() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    int? val = sharedPreferences.getInt(key);
    if (val == null) {
      await rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          getUserInfo();
          update();
          int newHealt = userSnapshot?.data()?["healt"] + 1;
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update(
            {
              "healt": newHealt,
            },
          );
          getUserInfo();
          int? val = sharedPreferences.getInt(key);
          if (val == null) {
            sharedPreferences.setInt(key, 1);
          } else {
            val = val + 1;
          }
          sharedPreferences.setInt(key, val!);

          update();
          watchFunc();
          debugPrint(key);
        },
      );
      getUserInfo();
    } else if (val <= 2) {
      await rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          int? val = sharedPreferences.getInt(key);
          if (val == null) {
            sharedPreferences.setInt(key, 1);
          } else {
            val = val + 1;
          }
          sharedPreferences.setInt(key, val!);
          plus();
          update();
          watchFunc();
        },
      );
    }

    update();
  }

  showRewardedAdGames() async {
    await rewardedAd?.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
        update();
      },
    );
    print("Reklam izleme tamamlandı!");
    update();
  }

  DocumentSnapshot<Map<String, dynamic>>? userSnapshot;

  getUserInfo() async {
    userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    update();
  }

  plus() {
    int newHealt = userSnapshot?.data()?["healt"] + 1;
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "healt": newHealt,
      },
    );
    getUserInfo();
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController paparaController = TextEditingController();
  TextEditingController usdtController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController operatorController = TextEditingController();
}

/*StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return 
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Bir şeyler ters gitti!"),
                );
              } else {
                return RegisterPage();
              }
            },
          ), */