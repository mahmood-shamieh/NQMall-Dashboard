import 'dart:convert';

class ValueModel {
  int? Id;
  String? ValueAr;
  String? ValueEn;
  String? HoverImageAr;
  String? HoverImageEn;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? attributeId;
  String? type;
  ValueModel({
    this.Id,
    this.ValueAr,
    this.ValueEn,
    this.HoverImageAr,
    this.HoverImageEn,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.attributeId,
    this.type,
  });

  ValueModel copyWith({
    int? Id,
    String? ValueAr,
    String? ValueEn,
    String? HoverImageAr,
    String? HoverImageEn,
    String? type,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? attributeId,
  }) {
    return ValueModel(
      Id: Id ?? this.Id,
      ValueAr: ValueAr ?? this.ValueAr,
      ValueEn: ValueEn ?? this.ValueEn,
      HoverImageAr: HoverImageAr ?? this.HoverImageAr,
      type: type ?? this.type,
      HoverImageEn: HoverImageEn ?? this.HoverImageEn,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      attributeId: attributeId ?? this.attributeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'ValueAr': ValueAr,
      'ValueEn': ValueEn,
      'HoverImageAr': HoverImageAr,
      'HoverImageEn': HoverImageEn,
      'type': type,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'attributeId': attributeId,
    };
  }

  factory ValueModel.fromMap(Map<String, dynamic> map) {
    return ValueModel(
      Id: map['Id'] != null ? map['Id'] : null,
      ValueAr: map['ValueAr'] != null ? map['ValueAr'] : null,
      ValueEn: map['ValueEn'] != null ? map['ValueEn'] : null,
      HoverImageAr: map['HoverImageAr'] != null ? map['HoverImageAr'] : null,
      HoverImageEn: map['HoverImageEn'] != null ? map['HoverImageEn'] : null,
      type: map['type'] != null ? map['type'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      attributeId: map['attributeId'] != null ? map['attributeId'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValueModel.fromJson(String source) =>
      ValueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ValueModel(Id: $Id, ValueAr: $ValueAr, ValueEn: $ValueEn, HoverImageAr: $HoverImageAr, HoverImageEn: $HoverImageEn, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, attributeId: $attributeId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueModel &&
        other.Id == Id &&
        other.ValueAr == ValueAr &&
        other.ValueEn == ValueEn &&
        other.HoverImageAr == HoverImageAr &&
        other.HoverImageEn == HoverImageEn &&
        other.type == type &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.attributeId == attributeId;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        ValueAr.hashCode ^
        ValueEn.hashCode ^
        HoverImageAr.hashCode ^
        HoverImageEn.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        attributeId.hashCode;
  }
}
