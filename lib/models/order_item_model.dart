import 'dart:convert';

import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/variation_model.dart';

class OrderItemModel {
  int? Id;
  int? Quantity;
  String? Price;
  String? SalePrice;
  bool? IsActive;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? variationId;
  int? productId;
  int? orderId;
  ProductModel? product;
  VariationModel? variation;
  OrderItemModel({
    this.Id,
    this.Quantity,
    this.Price,
    this.SalePrice,
    this.IsActive,
    this.CreatedAt,
    this.UpdatedAt,
    this.variationId,
    this.productId,
    this.orderId,
    this.product,
    this.variation,
  });

  OrderItemModel copyWith({
    int? Id,
    int? Quantity,
    String? Price,
    String? SalePrice,
    bool? IsActive,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? variationId,
    int? productId,
    int? orderId,
    ProductModel? product,
    VariationModel? variation,
  }) {
    return OrderItemModel(
      Id: Id ?? this.Id,
      Quantity: Quantity ?? this.Quantity,
      Price: Price ?? this.Price,
      SalePrice: SalePrice ?? this.SalePrice,
      IsActive: IsActive ?? this.IsActive,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      variationId: variationId ?? this.variationId,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      product: product ?? this.product,
      variation: variation ?? this.variation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Quantity': Quantity,
      'Price': Price,
      'SalePrice': SalePrice,
      'IsActive': IsActive,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'variationId': variationId,
      'productId': productId,
      'orderId': orderId,
      'product': product?.toMap(),
      'variation': variation?.toMap(),
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      Id: map['Id'] != null ? map['Id'] : null,
      Quantity: map['Quantity'] != null ? map['Quantity'] : null,
      Price: map['Price'] != null ? map['Price'] : null,
      SalePrice: map['SalePrice'] != null ? map['SalePrice'] : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      variationId: map['variationId'] != null ? map['variationId'] : null,
      productId: map['productId'] != null ? map['productId'] : null,
      orderId: map['orderId'] != null ? map['orderId'] : null,
      product:
          map['product'] != null ? ProductModel.fromMap(map['product']) : null,
      variation: map['variation'] != null
          ? VariationModel.fromMap(map['variation'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderItemModel(Id: $Id, Quantity: $Quantity, Price: $Price, SalePrice: $SalePrice, IsActive: $IsActive, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, variationId: $variationId, productId: $productId, orderId: $orderId, product: $product, variation: $variation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItemModel &&
        other.Id == Id &&
        other.Quantity == Quantity &&
        other.Price == Price &&
        other.SalePrice == SalePrice &&
        other.IsActive == IsActive &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.variationId == variationId &&
        other.productId == productId &&
        other.orderId == orderId &&
        other.product == product &&
        other.variation == variation;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Quantity.hashCode ^
        Price.hashCode ^
        SalePrice.hashCode ^
        IsActive.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        variationId.hashCode ^
        productId.hashCode ^
        orderId.hashCode ^
        product.hashCode ^
        variation.hashCode;
  }
}
