// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nq_mall_dashboard/models/admin_prev_model.dart';
import 'package:nq_mall_dashboard/models/app_config_model.dart';

class UserModel {
  int? Id;
  String? Email;
  String? PasswordHash;
  String? password;
  String? Token;
  String? FullName;
  String? Address;
  String? PhoneNumber;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  bool? IsActive;
  String? Role;
  String? FcmToken;
  List<AdminPrevModel>? admin_prevs;
  AppConfigModel? appConfig;
  UserModel({
    this.Id,
    this.Email,
    this.PasswordHash,
    this.password,
    this.Token,
    this.FullName,
    this.Address,
    this.PhoneNumber,
    this.CreatedAt,
    this.UpdatedAt,
    this.IsActive,
    this.Role,
    this.FcmToken,
    this.admin_prevs,
    this.appConfig,
  });

  UserModel copyWith({
    int? Id,
    String? Email,
    String? PasswordHash,
    String? password,
    String? Token,
    String? FullName,
    String? Address,
    String? PhoneNumber,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
    bool? IsActive,
    String? Role,
    String? FcmToken,
    List<AdminPrevModel>? admin_prevs,
    AppConfigModel? appConfig,
  }) {
    return UserModel(
      Id: Id ?? this.Id,
      Email: Email ?? this.Email,
      PasswordHash: PasswordHash ?? this.PasswordHash,
      password: password ?? this.password,
      Token: Token ?? this.Token,
      FullName: FullName ?? this.FullName,
      Address: Address ?? this.Address,
      PhoneNumber: PhoneNumber ?? this.PhoneNumber,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
      IsActive: IsActive ?? this.IsActive,
      Role: Role ?? this.Role,
      FcmToken: FcmToken ?? this.FcmToken,
      admin_prevs: admin_prevs ?? this.admin_prevs,
      appConfig: appConfig ?? this.appConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Email': Email,
      'PasswordHash': PasswordHash,
      'password': password,
      'Token': Token,
      'FullName': FullName,
      'Address': Address,
      'PhoneNumber': PhoneNumber,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
      'IsActive': IsActive,
      'Role': Role,
      'FcmToken': FcmToken,
      'admin_prevs': admin_prevs?.map((x) => x.toMap()).toList(),
      'appConfig': appConfig?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Id: map['Id'] != null ? map['Id'] as int : null,
      Email: map['Email'] != null ? map['Email'] as String : null,
      PasswordHash:
          map['PasswordHash'] != null ? map['PasswordHash'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      Token: map['Token'] != null ? map['Token'] as String : null,
      FullName: map['FullName'] != null ? map['FullName'] as String : null,
      Address: map['Address'] != null ? map['Address'] as String : null,
      PhoneNumber:
          map['PhoneNumber'] != null ? map['PhoneNumber'] as String : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
      IsActive: map['IsActive'] != null ? map['IsActive'] as bool : null,
      Role: map['Role'] != null ? map['Role'] as String : null,
      FcmToken: map['FcmToken'] != null ? map['FcmToken'] as String : null,
      admin_prevs: map['admin_prevs'] != null
          ? List<AdminPrevModel>.from(
              map['admin_prevs'].map((x) => AdminPrevModel.fromMap(x)))
          : null,
      appConfig: map['appConfig'] != null
          ? AppConfigModel.fromMap(map['appConfig'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(Id: $Id, Email: $Email, PasswordHash: $PasswordHash, password: $password, Token: $Token, FullName: $FullName, Address: $Address, PhoneNumber: $PhoneNumber, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt, IsActive: $IsActive, Role: $Role, FcmToken: $FcmToken, admin_prevs: $admin_prevs, appConfig: $appConfig)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.Email == Email &&
        other.PasswordHash == PasswordHash &&
        other.password == password &&
        other.Token == Token &&
        other.FullName == FullName &&
        other.Address == Address &&
        other.PhoneNumber == PhoneNumber &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt &&
        other.IsActive == IsActive &&
        other.Role == Role &&
        other.FcmToken == FcmToken &&
        other.appConfig == appConfig;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        Email.hashCode ^
        PasswordHash.hashCode ^
        password.hashCode ^
        Token.hashCode ^
        FullName.hashCode ^
        Address.hashCode ^
        PhoneNumber.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode ^
        IsActive.hashCode ^
        Role.hashCode ^
        FcmToken.hashCode ^
        appConfig.hashCode;
  }
}
