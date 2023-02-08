import 'dart:convert';
import 'package:deprem_destek/config/app_config.dart';
import 'package:flutter/material.dart';

class AppImages {
  static const commonImage = AppConfig.commonImage;

  static final MemoryImage askLocationPage1 = MemoryImage(
    base64Decode(commonImage['ask_location_page1'] ?? ''),
  );
  static final MemoryImage askLocationPage2 = MemoryImage(
    base64Decode(commonImage['ask_location_page2'] ?? ''),
  );
  static final MemoryImage askLocationPage3 = MemoryImage(
    base64Decode(commonImage['ask_location_page3'] ?? ''),
  );
}
