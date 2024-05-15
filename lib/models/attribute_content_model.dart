import 'dart:convert';

class AttributeContentModel {
  String? item;
  String? hoverImage;
  AttributeContentModel({
    this.item,
    this.hoverImage,
  });

  AttributeContentModel copyWith({
    String? item,
    String? hoverImage,
  }) {
    return AttributeContentModel(
      item: item ?? this.item,
      hoverImage: hoverImage ?? this.hoverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'hoverImage': hoverImage,
    };
  }

  factory AttributeContentModel.fromMap(Map<String, dynamic> map) {
    return AttributeContentModel(
      item: map['item'] != null ? map['item'] : null,
      hoverImage: map['hoverImage'] != null ? map['hoverImage'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeContentModel.fromJson(String source) =>
      AttributeContentModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MediaContentModel(item: $item, hoverImage: $hoverImage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AttributeContentModel &&
        other.item == item &&
        other.hoverImage == hoverImage;
  }

  @override
  int get hashCode => item.hashCode ^ hoverImage.hashCode;
}
