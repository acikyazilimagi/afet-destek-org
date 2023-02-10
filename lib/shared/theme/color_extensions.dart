import 'package:flutter/material.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';

part 'color_extensions.g.theme.dart';

@themeExtensions
class AppColorsExtension extends ThemeExtension<AppColorsExtension>
    with _$ThemeExtensionMixin {
  const AppColorsExtension({
    this.black = const Color(0xFF000000),
    this.mainRed = const Color(0xFFDC2626),
    this.secondaryBackground = const Color(0xFFF7F7F7),
    this.white = const Color(0xFFFFFFFF),
    this.subtitles = const Color(0xFF475467),
    this.titles = const Color(0xFF101828),
    this.paragraph = const Color(0xFF344054),
    this.whatsApp = const Color(0xFF25D366),
    this.tags = const Color(0xFF344054),
    this.disabledButton = const Color(0xFFB6C0D5),
    this.disabledStroke = const Color(0xFFD9E1E7),
    this.stroke = const Color(0xFFD0D5DD),
    this.errorStroke = const Color(0xFFB71C1C),
    this.mainBackground = const Color(0xFFFFFFFF),
    this.notificationTermTexts = const Color(0xFF667085),
    this.tagsTermsInputTexts = const Color(0xFF686868),
  });

  factory AppColorsExtension.dark() {
    return const AppColorsExtension(
      secondaryBackground: Color(0xFF252525),
      subtitles: Color(0xFFD3D3D3),
      titles: Color(0xFFFFFFFF),
      paragraph: Color(0xFFB7B7B7),
      tags: Color(0xFFFFFFFF),
      disabledButton: Color(0xFF686868),
      stroke: Color(0xFF343434),
      mainBackground: Color(0xFF1D1D1D),
      notificationTermTexts: Color(0xFFB7B7B7),
    );
  }
  final Color black;
  final Color mainRed;
  final Color secondaryBackground;
  final Color white;
  final Color subtitles;
  final Color titles;
  final Color paragraph;
  final Color whatsApp;
  final Color tags;
  final Color disabledButton;
  final Color disabledStroke;
  final Color stroke;
  final Color errorStroke;
  final Color mainBackground;
  final Color notificationTermTexts;
  final Color tagsTermsInputTexts;
}
