import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nq_mall_dashboard/models/attribute_content_model.dart';

class AttributeModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  bool? IsActive;
  int? productId;
  String? Type;
  List<AttributeContentModel>? ContentAr;
  List<AttributeContentModel>? ContentEn;
  DateTime? UpdatedAt;
  DateTime? CreatedAt;
  AttributeModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.IsActive,
    this.productId,
    this.Type,
    this.ContentAr,
    this.ContentEn,
    this.UpdatedAt,
    this.CreatedAt,
  });

  AttributeModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    bool? IsActive,
    int? productId,
    String? Type,
    List<AttributeContentModel>? ContentAr,
    List<AttributeContentModel>? ContentEn,
    DateTime? UpdatedAt,
    DateTime? CreatedAt,
  }) {
    return AttributeModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      IsActive: IsActive ?? this.IsActive,
      productId: productId ?? this.productId,
      Type: Type ?? this.Type,
      ContentAr: ContentAr ?? this.ContentAr,
      ContentEn: ContentEn ?? this.ContentEn,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      CreatedAt: CreatedAt ?? this.CreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'IsActive': IsActive,
      'productId': productId,
      'Type': Type,
      'ContentAr': ContentAr?.map((x) => x?.toMap())?.toList(),
      'ContentEn': ContentEn?.map((x) => x?.toMap())?.toList(),
      'UpdatedAt': UpdatedAt?.toString(),
      'CreatedAt': CreatedAt?.toString(),
    };
  }

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      productId: map['productId'] != null ? map['productId'] : null,
      Type: map['Type'] != null ? map['Type'] : null,
      ContentAr: map['ContentAr'] != null
          ? List<AttributeContentModel>.from(
              map['ContentAr']?.map((x) => AttributeContentModel.fromMap(x)))
          : null,
      ContentEn: map['ContentEn'] != null
          ? List<AttributeContentModel>.from(
              map['ContentEn']?.map((x) => AttributeContentModel.fromMap(x)))
          : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeModel.fromJson(String source) =>
      AttributeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AttributeModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, IsActive: $IsActive, productId: $productId, Type: $Type, ContentAr: $ContentAr, ContentEn: $ContentEn, UpdatedAt: $UpdatedAt, CreatedAt: $CreatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttributeModel &&
        other.Id == Id &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.IsActive == IsActive &&
        other.productId == productId &&
        other.Type == Type &&
        listEquals(other.ContentAr, ContentAr) &&
        listEquals(other.ContentEn, ContentEn) &&
        other.UpdatedAt == UpdatedAt &&
        other.CreatedAt == CreatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        IsActive.hashCode ^
        productId.hashCode ^
        Type.hashCode ^
        ContentAr.hashCode ^
        ContentEn.hashCode ^
        UpdatedAt.hashCode ^
        CreatedAt.hashCode;
  }
}
