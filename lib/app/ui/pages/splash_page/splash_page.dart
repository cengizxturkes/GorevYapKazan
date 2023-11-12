import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/register_page/register_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/root_page/root_page.dart';

import '../../../controllers/chest_controller.dart';
import '../../../controllers/followus_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/main_controller.dart';
import '../../../controllers/market_controller.dart';
import '../../../controllers/mining_controller.dart';
import '../../../controllers/pullmoney_controller.dart';
import '../../../controllers/register_controller.dart';
import '../../../controllers/root_controller.dart';
import '../../../controllers/wheel_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    userLoginControl();
    super.initState();
  }

  userLoginControl() async {
    if (mounted) {
      await Get.put(HomeController(), permanent: true);
      await Get.put(ChestController(), permanent: true);
      await Get.put(FollowUsController(), permanent: true);
      await Get.put(LoginController(), permanent: true);
      await Get.put(MainController(), permanent: true);
      await Get.put(MarketController(), permanent: true);
      await Get.put(PullMoneyController(), permanent: true);
      await Get.put(RegisterController(), permanent: true);
      await Get.put(RootController(), permanent: true);
      await Get.put(WheelController(), permanent: true);
      await Get.put(MiningController(), permanent: true);
      User? user = await FirebaseAuth.instance.currentUser;
      if (user != null) {
          Get.offAll(() => RootPage());
      } else {
          Get.offAll(() => RegisterPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
