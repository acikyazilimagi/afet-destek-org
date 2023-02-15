import 'package:freezed_annotation/freezed_annotation.dart';

part 'demand_category.freezed.dart';
part 'demand_category.g.dart';


@freezed
class DemandCategory with _$DemandCategory {
  const factory DemandCategory({
    required String id,
    required String name,
    @JsonKey(name: 'name_ar') required String nameAr,
    @JsonKey(name: 'name_en') required String nameEn,
  }) = _DemandCategory;

  const DemandCategory._();

  factory DemandCategory.fromJson(Map<String, dynamic> json) =>
      _$DemandCategoryFromJson(json);

  String localizedName(/*lang arg here*/) {
    return '';
  }
}
