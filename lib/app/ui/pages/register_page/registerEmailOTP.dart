import 'package:email_otp/email_otp.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/root_page/root_page.dart';

import '../../../../core/init/theme/color_manager.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.myauth}) : super(key: key);
  final EmailOTP myauth;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0.w, bottom: 20.w),
            child: Center(
                child: Image.asset(
              "assets/images/logo.png",
              width: 128.w,
            )),
          ),
          const SizedBox(height: 40),
          Text("E-posta Doğrulama", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 20.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(otpController: otp1Controller),
              Otp(otpController: otp2Controller),
              Otp(otpController: otp3Controller),
              Otp(otpController: otp4Controller),
            ],
          ),
          const SizedBox(height: 20),
          Text("Kodu Tekrar Gönder", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              if (await widget.myauth.verifyOTP(
                      otp: otp1Controller.text + otp2Controller.text + otp3Controller.text + otp4Controller.text) ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RootPage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP"),
                ));
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Container(
                padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                decoration: BoxDecoration(
                  color: ColorManager.instance.fourth,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Gönder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.instance.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
      */