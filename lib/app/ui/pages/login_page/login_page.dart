import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:gorev_yap_kazan_app/app/ui/pages/root_page/root_page.dart';

import '../../../../core/init/theme/color_manager.dart';

import '../../../controllers/login_controller.dart';

import '../../global_widgets/ktextformfield.dart';


class LoginPage extends GetView<LoginController> {

  const LoginPage({super.key});


  @override

  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(

      backgroundColor: ColorManager.instance.primary,

      body: GetBuilder<LoginController>(

        builder: (c) {

          return GestureDetector(

            onTap: () {

              FocusManager.instance.primaryFocus?.unfocus();

            },

            child: SingleChildScrollView(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  Padding(

                    padding: EdgeInsets.only(

                      top: 50.w,

                    ),

                    child: Center(

                      child: Image.asset(

                        "assets/images/logo.png",

                        width: 128.w,

                      ),

                    ),

                  ),

                  Form(

                    key: formKey,

                    child: Column(

                      mainAxisSize: MainAxisSize.min,

                      mainAxisAlignment: MainAxisAlignment.center,

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Padding(

                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 15.w),

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


                              return null;

                            },

                          ),

                        ),

                      ],

                    ),

                  ),

                  Padding(

                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),

                    child: InkWell(

                      onTap: () async {

                        FocusManager.instance.primaryFocus?.unfocus();

                        try {

                          if (formKey.currentState!.validate()) {
                            var user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(

                              email: c.emailController.text,

                              password: c.passwordController.text,

                            );

                            Get.to(() => RootPage());

                          }

                        } on FirebaseAuthException catch (e) {

                          Get.closeAllSnackbars();

                          Get.snackbar("Error", e.message ?? "",
                              backgroundColor: ColorManager.instance.secondary);

                        }

                      },

                      child: Container(

                        padding: EdgeInsets.only(top: 14.h, bottom: 14.h),

                        decoration: BoxDecoration(

                            color: ColorManager.instance.fourth,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),

                        child: Center(

                          child: Text(

                            "Giriş Yap",

                            textAlign: TextAlign.center,

                            style: TextStyle(

                              color: ColorManager.instance.white,

                              fontSize: 18,

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

                        "Henüz Üyeliğin Yok Mu?",

                        style: TextStyle(

                          fontSize: 14,

                          color: ColorManager.instance.black,

                        ),

                      ),

                      GestureDetector(

                        onTap: () {

                          Get.back();

                        },

                        child: Padding(

                          padding: EdgeInsets.only(left: 6.w),

                          child: Text(

                            "Üye Ol",

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

