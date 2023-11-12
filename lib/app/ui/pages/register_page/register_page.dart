import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gorev_yap_kazan_app/app/ui/pages/home_page/home_page.dart';

import 'package:gorev_yap_kazan_app/app/ui/pages/register_page/registerEmailOTP.dart';

import '../../../../core/init/theme/color_manager.dart';
import '../../../controllers/register_controller.dart';
import '../../global_widgets/ktextformfield.dart';
import '../login_page/login_page.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    EmailOTP auth = EmailOTP();

    return Scaffold(
      backgroundColor: ColorManager.instance.primary,
      body: GetBuilder<RegisterController>(
        builder: (c) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.0.w, bottom: 20.w),
                    child: Center(
                        child: Image.asset(
                      "assets/images/logo.png",
                      width: 128.w,
                    )),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: KTextFormField.instance.widget(
                            context: context,
                            controller: c.fullNameController,
                            labelText: "Adı",
                            maxLines: 1,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Lütfen bu alanı doldurunuz.";
                              }

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: KTextFormField.instance.widget(
                            context: context,
                            controller: c.surnameController,
                            labelText: "Soyadı",
                            maxLines: 1,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Lütfen bu alanı doldurunuz.";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: KTextFormField.instance.widget(
                            context: context,
                            controller: c.emailController,
                            labelText: "E-posta",
                            maxLines: 1,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Lütfen bu alanı doldurunuz.";
                              }

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.w,
                          ),
                          child: KTextFormField.instance.widget(
                            context: context,
                            controller: c.passwordController,
                            labelText: "Şifre",
                            obscureText: true,
                            maxLines: 1,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Lütfen bu alanı doldurunuz.";
                              }
                              if (val.length < 6) {
                                return "Lütfen en az 6 karakter giriniz.";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: c.emailController.text,
                            password: c.passwordController.text,
                          );
                          if (credential.user?.email != null) {
                            auth.setConfig(
                                appEmail: "ozturkkaan411@gmail.com",
                                appName: "MozPara",
                                userEmail: c.emailController.text,
                                otpLength: 4,
                                otpType: OTPType.digitsOnly);
                            if (await auth.sendOTP() == true) {
                              print("true");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                            myauth: auth,
                                          )));
                            } else {
                              print("not");
                            }
                            await FirebaseFirestore.instance.collection("users").doc(credential.user?.uid).set(
                              {
                                "name": c.fullNameController.text,
                                "surname": c.surnameController.text,
                                "email": c.emailController.text,
                                "uid": credential.user?.uid,
                                "healt": 5,
                                "money": 0,
                              },
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          Get.closeAllSnackbars();
                          Get.snackbar("Error", e.message ?? "", backgroundColor: ColorManager.instance.secondary);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
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
                            "Üye Ol",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Zaten Bir Üyeliğin Var Mı?",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorManager.instance.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginPage());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: ColorManager.instance.fourth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
