import 'dart:convert';

import 'package:afet_destek/gen/translations/locale_keys.g.dart';
import 'package:afet_destek/pages/location_tutorial/base64/base_64_images.dart';
import 'package:afet_destek/shared/extensions/translation_extension.dart';
import 'package:flutter/material.dart';

enum AppleTutorialImages {
  p1,
  p2,
  p3,
  p4,
  p5;

  MemoryImage get getImage {
    switch (this) {
      case AppleTutorialImages.p1:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['appleImage1'] ?? ''),
        );
      case AppleTutorialImages.p2:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['appleImage2'] ?? ''),
        );
      case AppleTutorialImages.p3:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['appleImage3'] ?? ''),
        );
      case AppleTutorialImages.p4:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['appleImage3'] ?? ''),
        );
      case AppleTutorialImages.p5:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['appleImage4'] ?? ''),
        );
    }
  }

  String get title {
    switch (this) {
      case AppleTutorialImages.p1:
        return LocaleKeys.apple_tutorial_settings.getStr();
      case AppleTutorialImages.p2:
        return LocaleKeys.apple_tutorial_privacy.getStr();
      case AppleTutorialImages.p3:
        return LocaleKeys.apple_tutorial_location.getStr();
      case AppleTutorialImages.p4:
        return LocaleKeys.apple_tutorial_closed.getStr();
      case AppleTutorialImages.p5:
        return LocaleKeys.apple_tutorial_opened.getStr();
    }
  }
}

enum AndroidTutorialImages {
  p1,
  p2,
  p3,
  p4;

  MemoryImage get getImage {
    switch (this) {
      case AndroidTutorialImages.p1:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['androidImage1'] ?? ''),
        );
      case AndroidTutorialImages.p2:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['androidImage2'] ?? ''),
        );
      case AndroidTutorialImages.p3:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['androidImage3'] ?? ''),
        );
      case AndroidTutorialImages.p4:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['androidImage4'] ?? ''),
        );
    }
  }

  String get title {
    switch (this) {
      case AndroidTutorialImages.p1:
        return LocaleKeys.android_tutorial_settings.getStr();
      case AndroidTutorialImages.p2:
        return LocaleKeys.android_tutorial_location.getStr();
      case AndroidTutorialImages.p3:
        return LocaleKeys.android_tutorial_closed.getStr();
      case AndroidTutorialImages.p4:
        return LocaleKeys.android_tutorial_opened.getStr();
    }
  }
}

enum ChromeTutorialImages {
  p1,
  p2,
  p3,
  p4;

  MemoryImage get getImage {
    switch (this) {
      case ChromeTutorialImages.p1:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['chromeImage1'] ?? ''),
        );
      case ChromeTutorialImages.p2:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['chromeImage2'] ?? ''),
        );
      case ChromeTutorialImages.p3:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['chromeImage3'] ?? ''),
        );
      case ChromeTutorialImages.p4:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['chromeImage4'] ?? ''),
        );
    }
  }

  String get title {
    switch (this) {
      case ChromeTutorialImages.p1:
        return LocaleKeys.chrome_tutorial_settings.getStr();
      case ChromeTutorialImages.p2:
        return LocaleKeys.chrome_tutorial_location.getStr();
      case ChromeTutorialImages.p3:
        return LocaleKeys.chrome_tutorial_closed.getStr();
      case ChromeTutorialImages.p4:
        return LocaleKeys.chrome_tutorial_opened.getStr();
    }
  }
}

enum SafariTutorialImages {
  p1,
  p2,
  p3,
  p4;

  MemoryImage get getImage {
    switch (this) {
      case SafariTutorialImages.p1:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['safariImage1'] ?? ''),
        );
      case SafariTutorialImages.p2:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['safariImage2'] ?? ''),
        );
      case SafariTutorialImages.p3:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['safariImage3'] ?? ''),
        );
      case SafariTutorialImages.p4:
        return MemoryImage(
          base64Decode(tutorialImagesBase64['safariImage4'] ?? ''),
        );
    }
  }

  String get title {
    switch (this) {
      case SafariTutorialImages.p1:
        return LocaleKeys.safari_tutorial_settings.getStr();
      case SafariTutorialImages.p2:
        return LocaleKeys.safari_tutorial_location.getStr();
      case SafariTutorialImages.p3:
        return LocaleKeys.safari_tutorial_closed.getStr();
      case SafariTutorialImages.p4:
        return LocaleKeys.safari_tutorial_opened.getStr();
    }
  }
}
