import 'dart:convert';
import 'package:afet_destek/pages/location_tutorial/base64/base_64_images.dart';
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
        return '1- Ayarlar';
      case AppleTutorialImages.p2:
        return '2- Gizlilik ve Güvenlik';
      case AppleTutorialImages.p3:
        return '3- Konum Servisleri';
      case AppleTutorialImages.p4:
        return '4- Kapalı Butonu';
      case AppleTutorialImages.p5:
        return '5- Açık Hale Getir';
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
        return '1- Ayarlar';
      case AndroidTutorialImages.p2:
        return '2- Konum Servisleri';
      case AndroidTutorialImages.p3:
        return '3- Kapalı Butonu';
      case AndroidTutorialImages.p4:
        return '4- Açık Hale Getir';
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
        return '1- Ayarlar';
      case ChromeTutorialImages.p2:
        return '2- Konum Servisleri';
      case ChromeTutorialImages.p3:
        return '3- Kapalı Butonu';
      case ChromeTutorialImages.p4:
        return '4- Açık Hale Getir';
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
        return '1- AA İkonuna bas';
      case SafariTutorialImages.p2:
        return '2- Konum Servisleri';
      case SafariTutorialImages.p3:
        return '3- Kapalı Butonu';
      case SafariTutorialImages.p4:
        return '4- Açık Hale Getir';
    }
  }
}
