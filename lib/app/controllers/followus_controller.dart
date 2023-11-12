import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FollowUsController extends GetxController {
  final Uri urlInsta = Uri.parse('https://www.instagram.com/invites/contact/?i=1rdihwicxo2nc&utm_content=qqwrnzm');
  Future<void> launchUrlInstaFunc() async {
    if (!await launchUrl(urlInsta)) {
      throw Exception('Could not launch $urlInsta');
    }
  }

  final Uri urlYoutube = Uri.parse('https://youtube.com/@mozpark2822');
  Future<void> launchUrlYoutubeFunc() async {
    if (!await launchUrl(urlYoutube)) {
      throw Exception('Could not launch $urlYoutube');
    }
  }

  final Uri urlTelegram = Uri.parse(
    'https://t.me/mozparareklamizlekazan',
  );
  Future<void> launchUrlTelegramFunc() async {
    if (!await launchUrl(urlTelegram, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlTelegram');
    }
  }
}
