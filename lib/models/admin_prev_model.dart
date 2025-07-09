import 'dart:convert';

import 'package:nq_mall_dashboard/models/section_model.dart';

class AdminPrevModel {
  int? Id;
  bool? Read;
  bool? Edit;
  bool? Delete;
  bool? Add;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  int? userId;
  int? sectionId;
  SectionModel? section;
  AdminPrevModel({
    this.Id,
    this.Read,
    this.Edit,
    this.Delete,
    this.Add,
    this.CreatedAt,
    this.UpdatedAt,
    this.userId,
    this.sectionId,
    this.section,
  });

  AdminPrevModel copyWith({
    int? Id,
    bool? Read,
    bool? Edit,
    bool? Delete,
    bool? Add,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    int? userId,
    int? sectionId,
    SectionModel? section,
  }) {
    return AdminPrevModel(
      Id: Id ?? this.Id,
      Read: Read ?? this.Read,
      Edit: Edit ?? this.Edit,
      Delete: Delete ?? this.Delete,
      Add: Add ?? this.Add,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      userId: userId ?? this.userId,
      sectionId: sectionId ?? this.sectionId,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Read': Read,
      'Edit': Edit,
      'Delete': Delete,
      'Add': Add,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'userId': userId,
      'sectionId': sectionId,
      'section': section?.toMap(),
    };
  }

  factory AdminPrevModel.fromMap(Map<String, dynamic> map) {
    return AdminPrevModel(
      Id: map['Id'] != null ? map['Id'] : null,
      Read: map['Read'] != null ? map['Read'] : null,
      Edit: map['Edit'] != null ? map['Edit'] : null,
      Delete: map['Delete'] != null ? map['Delete'] : null,
      Add: map['Add'] != null ? map['Add'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      userId: map['userId'] != null ? map['userId'] : null,
      sectionId: map['sectionId'] != null ? map['sectionId'] : null,
      section:
          map['section'] != null ? SectionModel.fromMap(map['section']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminPrevModel.fromJson(String source) =>
      AdminPrevModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdminPrevModel(Id: $Id, Read: $Read, Edit: $Edit, Delete: $Delete, Add: $Add, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, userId: $userId, sectionId: $sectionId, section: $section)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdminPrevModel &&
        other.Id == Id &&
        other.Read == Read &&
        other.Edit == Edit &&
        other.Delete == Delete &&
        other.Add == Add &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.userId == userId &&
        other.sectionId == sectionId &&
        other.section == section;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Read.hashCode ^
        Edit.hashCode ^
        Delete.hashCode ^
        Add.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        userId.hashCode ^
        sectionId.hashCode ^
        section.hashCode;
  }
}
