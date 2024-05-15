import 'dart:convert';

class BrandModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  String? LogoUrl;
  int? LogoSize;
  String? WebSiteUrl;
  bool? IsActive;
  String? DescriptionAr;
  String? DescriptionEn;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  BrandModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.LogoUrl,
    this.LogoSize,
    this.WebSiteUrl,
    this.IsActive,
    this.DescriptionAr,
    this.DescriptionEn,
    this.CreatedAt,
    this.UpdatedAt,
  });

  BrandModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    String? LogoUrl,
    int? LogoSize,
    String? WebSiteUrl,
    bool? IsActive,
    String? DescriptionAr,
    String? DescriptionEn,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return BrandModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      LogoUrl: LogoUrl ?? this.LogoUrl,
      LogoSize: LogoSize ?? this.LogoSize,
      WebSiteUrl: WebSiteUrl ?? this.WebSiteUrl,
      IsActive: IsActive ?? this.IsActive,
      DescriptionAr: DescriptionAr ?? this.DescriptionAr,
      DescriptionEn: DescriptionEn ?? this.DescriptionEn,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'LogoUrl': LogoUrl,
      'LogoSize': LogoSize,
      'WebSiteUrl': WebSiteUrl,
      'IsActive': IsActive,
      'DescriptionAr': DescriptionAr,
      'DescriptionEn': DescriptionEn,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      LogoUrl: map['LogoUrl'] != null ? map['LogoUrl'] : null,
      LogoSize: map['LogoSize'] != null ? map['LogoSize'] : null,
      WebSiteUrl: map['WebSiteUrl'] != null ? map['WebSiteUrl'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      DescriptionAr: map['DescriptionAr'] != null ? map['DescriptionAr'] : null,
      DescriptionEn: map['DescriptionEn'] != null ? map['DescriptionEn'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BrandModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, LogoUrl: $LogoUrl, LogoSize: $LogoSize, WebSiteUrl: $WebSiteUrl, IsActive: $IsActive, DescriptionAr: $DescriptionAr, DescriptionEn: $DescriptionEn, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandModel && other.Id == Id;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        LogoUrl.hashCode ^
        LogoSize.hashCode ^
        WebSiteUrl.hashCode ^
        IsActive.hashCode ^
        DescriptionAr.hashCode ^
        DescriptionEn.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
