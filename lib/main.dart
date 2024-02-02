import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:gorev_yap_kazan_app/app/ui/utils/dynamicLink.dart';

import 'package:provider/provider.dart';

import 'app/ui/pages/splash_page/splash_page.dart';

import 'core/init/cache/cache_manager.dart';

import 'core/init/theme/color_manager.dart';

import 'firebase_options.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();


  SystemChrome.setPreferredOrientations(

    [DeviceOrientation.portraitUp],

  );


  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );

  DynamicLinkProvider().initDynamicLink();

  await GetStorage.init();

  KCacheManager.instance;

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override

  Widget build(BuildContext context) {

    return ScreenUtilInit(

      builder: (context, builder) => GetMaterialApp(

        title: "SpinningWheel",

        debugShowCheckedModeBanner: false,

        theme: ThemeData(

          primarySwatch: Colors.orange,

          scaffoldBackgroundColor: ColorManager.instance.white,

          fontFamily: "ArchivoBlack",

        ),

        getPages: [GetPage(name: "/", page: () => SplashPage())],

        initialRoute: "/",

      ),

    );

  }

}

