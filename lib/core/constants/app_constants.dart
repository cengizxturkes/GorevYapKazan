// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class ApplicationConstants {
  final String _appName = "Digital Desk";
  static String baseURL = "https://www.karaca.com";
  static const _locale = Locale('tr', 'TR');
  static const _fallbackLocale = Locale('en', 'US');

  get appName => _appName;

  Locale get locale => _locale;
  Locale get fallbackLocale => _fallbackLocale;
}
