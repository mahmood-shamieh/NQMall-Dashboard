// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nq_mall_dashboard/models/product_variations_value_model.dart';
import 'package:nq_mall_dashboard/models/value_model.dart';

class VariationModel {
  int? Id;
  String? Price;
  String? Stock;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? productId;
  List<ProductVariationValueModel>? product_variation_values;
  List<ValueModel>? Values;
  VariationModel({
    this.Id,
    this.Price,
    this.Stock,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.productId,
    this.product_variation_values,
    this.Values,
  });

  VariationModel copyWith({
    int? Id,
    String? Price,
    String? Stock,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? productId,
    List<ProductVariationValueModel>? product_variation_values,
    List<ValueModel>? Values,
  }) {
    return VariationModel(
      Id: Id ?? this.Id,
      Price: Price ?? this.Price,
      Stock: Stock ?? this.Stock,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      productId: productId ?? this.productId,
      product_variation_values:
          product_variation_values ?? this.product_variation_values,
      Values: Values ?? this.Values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Price': Price,
      'Stock': Stock,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'productId': productId,
      'product_variation_values':
          product_variation_values?.map((x) => x.toMap()).toList(),
      'Values': Values?.map((x) => x.toMap()).toList(),
    };
  }

  factory VariationModel.fromMap(Map<String, dynamic> map) {
    return VariationModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Price: map['Price'] != null ? map['Price'] as String : null,
      Stock: map['Stock'] != null ? map['Stock'] as String : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      product_variation_values: map['product_variation_values'] != null
          ? List<ProductVariationValueModel>.from(
              (map['product_variation_values'] as List)
                  .map<ProductVariationValueModel?>(
                (x) => ProductVariationValueModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      Values: map['Values'] != null
          ? List<ValueModel>.from(
              (map['Values'] as List).map<ValueModel?>(
                (x) => ValueModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariationModel.fromJson(String source) =>
      VariationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariationModel(Id: $Id, Price: $Price, Stock: $Stock, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, productId: $productId, product_variation_values: $product_variation_values, Values: $Values)';
  }

  @override
  bool operator ==(covariant VariationModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Price == Price &&
        other.Stock == Stock &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.productId == productId &&
        listEquals(other.product_variation_values, product_variation_values) &&
        listEquals(other.Values, Values);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Price.hashCode ^
        Stock.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        productId.hashCode ^
        product_variation_values.hashCode ^
        Values.hashCode;
  }
}
