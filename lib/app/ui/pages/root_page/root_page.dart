import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gorev_yap_kazan_app/app/controllers/home_controller.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/followus_page/followus_page.dart';

import 'package:gorev_yap_kazan_app/app/ui/pages/home_page/home_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/main_page/main_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/market_page/market_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/pullmoney_page/pullmoney_page.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/share_page/share_page.dart';
import 'package:provider/provider.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/root_controller.dart';
import '../register_page/register_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (c) {
      return GetBuilder<HomeController>(builder: (c1) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(initialIndex == 1
                ? c1.watch < 2
                    ? 200.w
                    : 140.w
                : initialIndex == 2
                    ? 120.w
                    : initialIndex == 3
                        ? 120.w
                        : initialIndex == 0
                            ? 200.w
                            : initialIndex == 4
                                ? 120.w
                                : initialIndex == 5
                                    ? 120.w
                                    : 120.w),
            child: Builder(builder: (context) {
              if (initialIndex == 2) {
                return AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: ColorManager.instance.fourth,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(top: 80.w),
                    child: Column(
                      children: [
                        Text(
                          'Market',
                          style: TextStyle(
                              color: ColorManager.instance.primary,
                              fontSize: 21),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0.w),
                          child: Text(
                            '1-48 Saat İçerisinde Hesabınıza Ulaşacaktır.',
                            style: GoogleFonts.archivo(
                                fontSize: 15,
                                color: ColorManager.instance.primary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/heart.png",
                                width: 24.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 3.0.w),
                                child: Text(
                                    c1.userSnapshot
                                            ?.data()?["healt"]
                                            .toString() ??
                                        " ",
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: Row(
                              children: [
                                Image.asset("assets/images/bills.png"),
                                Padding(
                                  padding: EdgeInsets.only(left: 3.0.w),
                                  child: Text(
                                      c1.userSnapshot
                                              ?.data()?["money"]
                                              .toString() ??
                                          " ",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (initialIndex == 1) {
                return GetBuilder<HomeController>(
                  builder: (c) {
                    return PreferredSize(
                      preferredSize: c.watch < 2
                          ? Size.fromHeight(200.w)
                          : Size.fromHeight(140.w),
                      child: AppBar(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        elevation: 0,
                        backgroundColor: ColorManager.instance.fourth,
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: 18.0.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/heart.png",
                                      width: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0.w),
                                      child: AutoSizeText(
                                        c.userSnapshot
                                                ?.data()?["healt"]
                                                .toString() ??
                                            " ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0.w),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/bills.png"),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.0.w),
                                        child: AutoSizeText(
                                            c.userSnapshot
                                                    ?.data()?["money"]
                                                    .toString() ??
                                                " ",
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        flexibleSpace: Padding(
                          padding: EdgeInsets.only(top: 100.0.w),
                          child: Column(
                            children: [
                              AutoSizeText(
                                "Hoş geldin"
                                " ${c.userSnapshot?.data()?["name"].toString()} !",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorManager.instance.white,
                                    fontSize: 21),
                              ),
                              c.watch < 2
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 22.0.w, left: 70.w, right: 70.w),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Reklam İzle"),
                                                content: Text(
                                                    "Reklamı izleyerek ödül kazanabilirsiniz."),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      c.showRewardedAd();
                                                       c.update();
                                                      c.watch++;
                                                    },
                                                    child: Text("İzle"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Kapat"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                ColorManager.instance.secondary,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            border: Border.all(
                                              color:
                                                  ColorManager.instance.primary,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/heart.png",
                                                width: 24,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.0.w),
                                                child: Text(
                                                  'Can Kazanmak İçin Reklam İzle',
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .instance.fourth,
                                                      fontSize: 9.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (initialIndex == 0) {
                return GetBuilder<HomeController>(
                  builder: (c) {
                    return PreferredSize(
                      preferredSize: Size.fromHeight(200.w),
                      child: AppBar(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        elevation: 0,
                        backgroundColor: ColorManager.instance.fourth,
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: 18.0.w),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/heart.png",
                                      width: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0.w),
                                      child: AutoSizeText(
                                        c.userSnapshot
                                                ?.data()?["healt"]
                                                .toString() ??
                                            " ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0.w),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/bills.png"),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.0.w),
                                        child: AutoSizeText(
                                            c.userSnapshot
                                                    ?.data()?["money"]
                                                    .toString() ??
                                                " ",
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        flexibleSpace: Padding(
                          padding: EdgeInsets.only(top: 100.0.w),
                          child: Column(
                            children: [
                              AutoSizeText(
                                "Hoş geldin"
                                " ${c.userSnapshot?.data()?["name"].toString()} !",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorManager.instance.white,
                                    fontSize: 21),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 22.0.w, left: 70.w, right: 70.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      initialIndex = 1;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Reklam İzle"),
                                          content: Text(
                                              "Reklamı izleyerek ödül kazanabilirsiniz."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                c.update();
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
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.instance.secondary,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color: ColorManager.instance.primary,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/heart.png",
                                          width: 24,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4.0.w),
                                          child: Text(
                                            'Can Kazanmak İçin Reklam İzle ',
                                            style: TextStyle(
                                                color: ColorManager
                                                    .instance.fourth,
                                                fontSize: 9.r),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (initialIndex == 3) {
                return GetBuilder<HomeController>(builder: (c) {
                  return AppBar(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: ColorManager.instance.fourth,
                      flexibleSpace: Padding(
                        padding: EdgeInsets.only(top: 80.0.w),
                        child: Column(
                          children: [
                            Text(
                              'Para Çek',
                              style: TextStyle(
                                  color: ColorManager.instance.primary,
                                  fontSize: 21),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6.0.w),
                              child: Text(
                                  '1-48 Saat İçerisinde Hesabınıza Ulaşacaktır',
                                  style: GoogleFonts.archivo(
                                      fontSize: 15,
                                      color: ColorManager.instance.white)),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/heart.png",
                                    width: 24.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.0.w),
                                    child: Text(
                                        c.userSnapshot
                                                ?.data()?["healt"]
                                                .toString() ??
                                            " ",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0.w),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/bills.png"),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0.w),
                                      child: Text(
                                          c.userSnapshot
                                                  ?.data()?["money"]
                                                  .toString() ??
                                              " ",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]);
                });
              } else if (initialIndex == 5) {
                return GetBuilder<HomeController>(
                  builder: (c) {
                    return AppBar(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: ColorManager.instance.fourth,
                      flexibleSpace: Padding(
                        padding: EdgeInsets.only(top: 80.0.w),
                        child: Column(
                          children: [
                            Text(
                              'Paylaş',
                              style: TextStyle(
                                  color: ColorManager.instance.primary,
                                  fontSize: 21),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6.0.w),
                              child: Text('Uygulamayı Paylaş ve Paranı Kazan',
                                  style: GoogleFonts.archivo(
                                      fontSize: 15,
                                      color: ColorManager.instance.white)),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 24.0.w),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/heart.png",
                                    width: 24.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.0.w),
                                    child: Text(
                                        c.userSnapshot
                                                ?.data()?["healt"]
                                                .toString() ??
                                            "0",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0.w),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/bills.png"),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0.w),
                                      child: Text(
                                          c.userSnapshot
                                                  ?.data()?["money"]
                                                  .toString() ??
                                              "0",
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (initialIndex == 4) {
                return GetBuilder<HomeController>(builder: (context) {
                  return AppBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: ColorManager.instance.fourth,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(top: 80.0.w),
                      child: Column(
                        children: [
                          Text(
                            'Görevler',
                            style: TextStyle(
                                color: ColorManager.instance.primary,
                                fontSize: 21),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.0.w),
                            child: Text('Görevleri yap paralar senin olsun',
                                style: GoogleFonts.archivo(
                                    fontSize: 15,
                                    color: ColorManager.instance.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
              return SizedBox();
            }),
          ),
          body: IndexedStack(
            index: initialIndex,
            children: [
              MainPage(),
              HomePage(),
              MarketPage(),
              PullMoneyPage(),
              TaskPage(),
              SharePage(),
            ],
          ),
          drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: ColorManager.instance.fourth,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Image.asset("assets/images/logo.png"),
              ),
              ListTile(
                title: const Text('Anasayfa'),
                onTap: () {
                  setState(() {
                    initialIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Para Kazan'),
                onTap: () {
                  setState(() {
                    initialIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Market'),
                onTap: () {
                  setState(() {
                    initialIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Para Çek'),
                onTap: () {
                  setState(() {
                    initialIndex = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Görevler'),
                onTap: () {
                  setState(() {
                    initialIndex = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Paylaş'),
                onTap: () {
                  setState(() {
                    initialIndex = 5;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                title: const Text('Çıkış Yap'),
                onTap: () async {
                  Get.off(RegisterPage());
                },
              ),
              Divider(),
            ]),
          ),
        );
      });
    });
  }
}
