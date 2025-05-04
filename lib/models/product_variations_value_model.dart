// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nq_mall_dashboard/models/value_model.dart';

class ProductVariationValueModel {
  int? Id;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? valueId;
  int? variationId;
  ValueModel? value;
  ProductVariationValueModel({
    this.Id,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.valueId,
    this.variationId,
    this.value,
  });

  ProductVariationValueModel copyWith({
    int? Id,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? valueId,
    int? variationId,
    ValueModel? value,
  }) {
    return ProductVariationValueModel(
      Id: Id ?? this.Id,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      valueId: valueId ?? this.valueId,
      variationId: variationId ?? this.variationId,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'valueId': valueId,
      'variationId': variationId,
      'value': value?.toMap(),
    };
  }

  factory ProductVariationValueModel.fromMap(Map<String, dynamic> map) {
    return ProductVariationValueModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      valueId: map['valueId'] != null ? map['valueId'] as int : null,
      variationId:
          map['variationId'] != null ? map['variationId'] as int : null,
      value: map['value'] != null
          ? ValueModel.fromMap(map['value'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariationValueModel.fromJson(String source) =>
      ProductVariationValueModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductVariationValueModel(Id: $Id, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, valueId: $valueId, variationId: $variationId, value: $value)';
  }

  @override
  bool operator ==(covariant ProductVariationValueModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.valueId == valueId &&
        other.variationId == variationId &&
        other.value == value;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        valueId.hashCode ^
        variationId.hashCode ^
        value.hashCode;
  }
}
