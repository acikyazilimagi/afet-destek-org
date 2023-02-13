import 'package:afet_destek/shared/state/lang_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demand_category.freezed.dart';
part 'demand_category.g.dart';

@freezed
class DemandCategory with _$DemandCategory {
  const factory DemandCategory({
    required String id,
    @protected required String name,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'name_en') required String nameEn,
  }) = _DemandCategory;
  const DemandCategory._();

  factory DemandCategory.fromJson(Map<String, dynamic> json) =>
      _$DemandCategoryFromJson(json);

  String localizedName(AppLang lang) {
    switch (lang) {
      case AppLang.ar:
        return nameAr;
      case AppLang.en:
        return nameEn;
      case AppLang.tr:
        return name;
    }
  }
}
