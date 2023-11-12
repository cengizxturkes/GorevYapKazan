import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isValidUsername = false;

  Future<bool> isValid(String username) async {
    QuerySnapshot<Map<String, dynamic>> s =
        await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
    if (s.docs.isNotEmpty) {
      isValidUsername = false;
      return false;
    } else {
      isValidUsername = true;
      return true;
    }
  }
}
