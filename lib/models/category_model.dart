import 'dart:convert';

class CategoryModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  String? DescriptionAr;
  String? DescriptionEn;
  String? ImageURL;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  CategoryModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.DescriptionAr,
    this.DescriptionEn,
    this.ImageURL,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
  });

  CategoryModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    String? DescriptionAr,
    String? DescriptionEn,
    String? ImageURL,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return CategoryModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      DescriptionAr: DescriptionAr ?? this.DescriptionAr,
      DescriptionEn: DescriptionEn ?? this.DescriptionEn,
      ImageURL: ImageURL ?? this.ImageURL,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'DescriptionAr': DescriptionAr,
      'DescriptionEn': DescriptionEn,
      'ImageURL': ImageURL,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      DescriptionAr: map['DescriptionAr'] != null ? map['DescriptionAr'] : null,
      DescriptionEn: map['DescriptionEn'] != null ? map['DescriptionEn'] : null,
      ImageURL: map['ImageURL'] != null ? map['ImageURL'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(Id: $Id,NameAr: $NameAr, NameEn: $NameEn, DescriptionAr: $DescriptionAr, DescriptionEn: $DescriptionEn, ImageURL: $ImageURL, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    // print("aaaa");
    // if (identical(this, other)) return true;

    return other is CategoryModel && other.Id == Id;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        DescriptionAr.hashCode ^
        DescriptionEn.hashCode ^
        ImageURL.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
