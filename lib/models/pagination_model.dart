import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaginationModel {
  int? total;
  int? totalPages;
  int? currentPage;
  List<Map<String, dynamic>>? data;
  PaginationModel({
    this.total,
    this.totalPages,
    this.currentPage,
    this.data,
  });

  PaginationModel copyWith({
    int? total,
    int? totalPages,
    int? currentPage,
    List<Map<String, dynamic>>? data,
  }) {
    return PaginationModel(
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'data': data,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      total: map['total'] != null ? map['total'] : null,
      totalPages: map['totalPages'] != null ? map['totalPages'] : null,
      currentPage: map['currentPage'] != null ? map['currentPage'] : null,
      data: map['data'] != null
          ? List<Map<String, dynamic>>.from(map['data']?.map((x) => x))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginationModel(total: $total, totalPages: $totalPages, currentPage: $currentPage, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginationModel &&
        other.total == total &&
        other.totalPages == totalPages &&
        other.currentPage == currentPage &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return total.hashCode ^
        totalPages.hashCode ^
        currentPage.hashCode ^
        data.hashCode;
  }
}
