import 'dart:convert';

class OrderStatusModel {
  int? Id;
  String? NameAr;
  String? NameEn;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  OrderStatusModel({
    this.Id,
    this.NameAr,
    this.NameEn,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
  });

  OrderStatusModel copyWith({
    int? Id,
    String? NameAr,
    String? NameEn,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return OrderStatusModel(
      Id: Id ?? this.Id,
      NameAr: NameAr ?? this.NameAr,
      NameEn: NameEn ?? this.NameEn,
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
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      Id: map['Id'] != null ? map['Id'] : null,
      NameAr: map['NameAr'] != null ? map['NameAr'] : null,
      NameEn: map['NameEn'] != null ? map['NameEn'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusModel.fromJson(String source) =>
      OrderStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderStatusModel(Id: $Id, NameAr: $NameAr, NameEn: $NameEn, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderStatusModel &&
        other.Id == Id &&
        other.NameAr == NameAr &&
        other.NameEn == NameEn &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        NameAr.hashCode ^
        NameEn.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
