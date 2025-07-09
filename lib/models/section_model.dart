import 'dart:convert';

class SectionModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  SectionModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.CreatedAt,
    this.UpdatedAt,
  });

  SectionModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return SectionModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'NameAr': NameAr,
      'NameEn': NameEn,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory SectionModel.fromMap(Map<String, dynamic> map) {
    return SectionModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionModel.fromJson(String source) =>
      SectionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SectionModel &&
        other.Id == Id &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
