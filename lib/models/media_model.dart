import 'dart:convert';

class MediaModel {
  int? Id;
  String? URL;
  String? Type;
  int? Size;
  bool? IsActive;
  int? productId;
  DateTime? UpdatedAt;
  DateTime? CreatedAt;
  MediaModel({
    this.Id,
    this.URL,
    this.Type,
    this.Size,
    this.IsActive,
    this.productId,
    this.UpdatedAt,
    this.CreatedAt,
  });

  MediaModel copyWith({
    int? Id,
    String? URL,
    String? Type,
    int? Size,
    bool? IsActive,
    int? productId,
    DateTime? UpdatedAt,
    DateTime? CreatedAt,
  }) {
    return MediaModel(
      Id: Id ?? this.Id,
      URL: URL ?? this.URL,
      Type: Type ?? this.Type,
      Size: Size ?? this.Size,
      IsActive: IsActive ?? this.IsActive,
      productId: productId ?? this.productId,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      CreatedAt: CreatedAt ?? this.CreatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'URL': URL,
      'Type': Type,
      'Size': Size,
      'IsActive': IsActive,
      'productId': productId,
      'UpdatedAt': UpdatedAt?.toString(),
      'CreatedAt': CreatedAt?.toString(),
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      Id: map['Id'] != null ? map['Id'] : null,
      URL: map['URL'] != null ? map['URL'] : null,
      Type: map['Type'] != null ? map['Type'] : null,
      Size: map['Size'] != null ? map['Size'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      productId: map['productId'] != null ? map['productId'] : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MediaModel(Id: $Id, URL: $URL, Type: $Type, Size: $Size, IsActive: $IsActive, productId: $productId, UpdatedAt: $UpdatedAt, CreatedAt: $CreatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MediaModel &&
        other.Id == Id &&
        other.URL == URL &&
        other.Type == Type &&
        other.Size == Size &&
        other.IsActive == IsActive &&
        other.productId == productId &&
        other.UpdatedAt == UpdatedAt &&
        other.CreatedAt == CreatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        URL.hashCode ^
        Type.hashCode ^
        Size.hashCode ^
        IsActive.hashCode ^
        productId.hashCode ^
        UpdatedAt.hashCode ^
        CreatedAt.hashCode;
  }
}
