import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nq_mall_dashboard/models/media_model.dart';

class ProductModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  String? DescriptionAr;
  String? DescriptionEn;
  int? Price;
  int? SalePrice;
  Map? DetailsAr;
  Map? DetailsEn;
  bool? IsActive;
  int? userId;
  int? categoryId;
  int? brandId;
  DateTime? UpdatedAt;
  DateTime? CreatedAt;
  List<MediaModel>? media;
  ProductModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.DescriptionAr,
    this.DescriptionEn,
    this.Price,
    this.SalePrice,
    this.DetailsAr,
    this.DetailsEn,
    this.IsActive,
    this.userId,
    this.categoryId,
    this.brandId,
    this.UpdatedAt,
    this.CreatedAt,
    this.media,
  });

  ProductModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    String? DescriptionAr,
    String? DescriptionEn,
    int? Price,
    int? SalePrice,
    Map? DetailsAr,
    Map? DetailsEn,
    bool? IsActive,
    int? userId,
    int? categoryId,
    int? brandId,
    DateTime? UpdatedAt,
    DateTime? CreatedAt,
    List<MediaModel>? media,
  }) {
    return ProductModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      DescriptionAr: DescriptionAr ?? this.DescriptionAr,
      DescriptionEn: DescriptionEn ?? this.DescriptionEn,
      Price: Price ?? this.Price,
      SalePrice: SalePrice ?? this.SalePrice,
      DetailsAr: DetailsAr ?? this.DetailsAr,
      DetailsEn: DetailsEn ?? this.DetailsEn,
      IsActive: IsActive ?? this.IsActive,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'DescriptionAr': DescriptionAr,
      'DescriptionEn': DescriptionEn,
      'Price': Price,
      'SalePrice': SalePrice,
      'DetailsAr': DetailsAr,
      'DetailsEn': DetailsEn,
      'IsActive': IsActive,
      'userId': userId,
      'categoryId': categoryId,
      'brandId': brandId,
      'UpdatedAt': UpdatedAt?.toString(),
      'CreatedAt': CreatedAt?.toString(),
      'media': media?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      DescriptionAr: map['DescriptionAr'] != null ? map['DescriptionAr'] : null,
      DescriptionEn: map['DescriptionEn'] != null ? map['DescriptionEn'] : null,
      Price: map['Price'] != null ? map['Price'] : null,
      SalePrice: map['SalePrice'] != null ? map['SalePrice'] : null,
      DetailsAr: map['DetailsAr'] != null ? map['DetailsAr'] : null,
      DetailsEn: map['DetailsEn'] != null ? map['DetailsEn'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      userId: map['userId'] != null ? map['userId'] : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] : null,
      brandId: map['brandId'] != null ? map['brandId'] : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      media: map['media'] != null
          ? List<MediaModel>.from(
              map['media']?.map((x) => MediaModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, DescriptionAr: $DescriptionAr, DescriptionEn: $DescriptionEn, Price: $Price, SalePrice: $SalePrice, DetailsAr: $DetailsAr, DetailsEn: $DetailsEn, IsActive: $IsActive, userId: $userId, categoryId: $categoryId, brandId: $brandId, UpdatedAt: $UpdatedAt, CreatedAt: $CreatedAt, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
            other.Id ==
                Id /*  &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.DescriptionAr == DescriptionAr &&
        other.DescriptionEn == DescriptionEn &&
        other.Price == Price &&
        other.SalePrice == SalePrice &&
        other.DetailsAr == DetailsAr &&
        other.DetailsEn == DetailsEn &&
        other.IsActive == IsActive &&
        other.userId == userId &&
        other.categoryId == categoryId &&
        other.brandId == brandId &&
        other.UpdatedAt == UpdatedAt &&
        other.CreatedAt == CreatedAt &&
        listEquals(other.media, media) */
        ;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        DescriptionAr.hashCode ^
        DescriptionEn.hashCode ^
        Price.hashCode ^
        SalePrice.hashCode ^
        DetailsAr.hashCode ^
        DetailsEn.hashCode ^
        IsActive.hashCode ^
        userId.hashCode ^
        categoryId.hashCode ^
        brandId.hashCode ^
        UpdatedAt.hashCode ^
        CreatedAt.hashCode ^
        media.hashCode;
  }
}
