// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element

part of 'color_extensions.dart';

// **************************************************************************
// ThemeExtensionsGenerator
// **************************************************************************

mixin _$ThemeExtensionMixin on ThemeExtension<AppColorsExtension> {
  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? black,
    Color? mainRed,
    Color? secondaryBackground,
    Color? white,
    Color? subtitles,
    Color? titles,
    Color? paragraph,
    Color? whatsApp,
    Color? tags,
    Color? disabledButton,
    Color? disabledStroke,
    Color? stroke,
    Color? errorStroke,
    Color? mainBackground,
    Color? notificationTermTexts,
    Color? tagsTermsInputTexts,
  }) {
    final object = this as AppColorsExtension;

    return AppColorsExtension(
      black: black ?? object.black,
      mainRed: mainRed ?? object.mainRed,
      secondaryBackground: secondaryBackground ?? object.secondaryBackground,
      white: white ?? object.white,
      subtitles: subtitles ?? object.subtitles,
      titles: titles ?? object.titles,
      paragraph: paragraph ?? object.paragraph,
      whatsApp: whatsApp ?? object.whatsApp,
      tags: tags ?? object.tags,
      disabledButton: disabledButton ?? object.disabledButton,
      disabledStroke: disabledStroke ?? object.disabledStroke,
      stroke: stroke ?? object.stroke,
      errorStroke: errorStroke ?? object.errorStroke,
      mainBackground: mainBackground ?? object.mainBackground,
      notificationTermTexts:
          notificationTermTexts ?? object.notificationTermTexts,
      tagsTermsInputTexts: tagsTermsInputTexts ?? object.tagsTermsInputTexts,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    final otherValue = other;

    if (otherValue is! AppColorsExtension) {
      return this;
    }

    final value = this as AppColorsExtension;

    return AppColorsExtension(
      black: Color.lerp(
        value.black,
        otherValue.black,
        t,
      )!,
      mainRed: Color.lerp(
        value.mainRed,
        otherValue.mainRed,
        t,
      )!,
      secondaryBackground: Color.lerp(
        value.secondaryBackground,
        otherValue.secondaryBackground,
        t,
      )!,
      white: Color.lerp(
        value.white,
        otherValue.white,
        t,
      )!,
      subtitles: Color.lerp(
        value.subtitles,
        otherValue.subtitles,
        t,
      )!,
      titles: Color.lerp(
        value.titles,
        otherValue.titles,
        t,
      )!,
      paragraph: Color.lerp(
        value.paragraph,
        otherValue.paragraph,
        t,
      )!,
      whatsApp: Color.lerp(
        value.whatsApp,
        otherValue.whatsApp,
        t,
      )!,
      tags: Color.lerp(
        value.tags,
        otherValue.tags,
        t,
      )!,
      disabledButton: Color.lerp(
        value.disabledButton,
        otherValue.disabledButton,
        t,
      )!,
      disabledStroke: Color.lerp(
        value.disabledStroke,
        otherValue.disabledStroke,
        t,
      )!,
      stroke: Color.lerp(
        value.stroke,
        otherValue.stroke,
        t,
      )!,
      errorStroke: Color.lerp(
        value.errorStroke,
        otherValue.errorStroke,
        t,
      )!,
      mainBackground: Color.lerp(
        value.mainBackground,
        otherValue.mainBackground,
        t,
      )!,
      notificationTermTexts: Color.lerp(
        value.notificationTermTexts,
        otherValue.notificationTermTexts,
        t,
      )!,
      tagsTermsInputTexts: Color.lerp(
        value.tagsTermsInputTexts,
        otherValue.tagsTermsInputTexts,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    final value = this as AppColorsExtension;

    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppColorsExtension &&
            identical(value.black, other.black) &&
            identical(value.mainRed, other.mainRed) &&
            identical(value.secondaryBackground, other.secondaryBackground) &&
            identical(value.white, other.white) &&
            identical(value.subtitles, other.subtitles) &&
            identical(value.titles, other.titles) &&
            identical(value.paragraph, other.paragraph) &&
            identical(value.whatsApp, other.whatsApp) &&
            identical(value.tags, other.tags) &&
            identical(value.disabledButton, other.disabledButton) &&
            identical(value.disabledStroke, other.disabledStroke) &&
            identical(value.stroke, other.stroke) &&
            identical(value.errorStroke, other.errorStroke) &&
            identical(value.mainBackground, other.mainBackground) &&
            identical(
                value.notificationTermTexts, other.notificationTermTexts) &&
            identical(value.tagsTermsInputTexts, other.tagsTermsInputTexts));
  }

  @override
  int get hashCode {
    final value = this as AppColorsExtension;

    return Object.hash(
      runtimeType,
      value.black,
      value.mainRed,
      value.secondaryBackground,
      value.white,
      value.subtitles,
      value.titles,
      value.paragraph,
      value.whatsApp,
      value.tags,
      value.disabledButton,
      value.disabledStroke,
      value.stroke,
      value.errorStroke,
      value.mainBackground,
      value.notificationTermTexts,
      value.tagsTermsInputTexts,
    );
  }
}

extension AppColorsExtensionBuildContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
