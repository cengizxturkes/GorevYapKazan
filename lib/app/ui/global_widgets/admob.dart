import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdmob extends StatefulWidget {
  const BannerAdmob({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BannerAdmobState();
  }
}

class _BannerAdmobState extends State<BannerAdmob> {
  late BannerAd _bannerAd;
  bool _bannerReady = false;
  //'ca-app-pub-1096844369653763/3924116722'; //real
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-1096844369653763/3924116722",
      request: const AdRequest(keywords: [
        "game",
        "roll",
        "health",
      ]),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _bannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _bannerReady = false;
          });
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerReady
        ? SizedBox(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : Container();
  }
}
