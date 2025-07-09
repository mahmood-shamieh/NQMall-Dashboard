import 'dart:convert';

class AppConfigModel {
  int? Id;
  String? App_IOS_Version;
  String? Dashboard_IOS_Version;
  String? App_Android_Version;
  String? Dashboard_Android_Version;
  bool? AppEnabled;
  bool? DashboardEnabled;
  DateTime? CreatedAt;
  DateTime? UpdatedAt;
  AppConfigModel({
    this.Id,
    this.App_IOS_Version,
    this.Dashboard_IOS_Version,
    this.App_Android_Version,
    this.Dashboard_Android_Version,
    this.AppEnabled,
    this.DashboardEnabled,
    this.CreatedAt,
    this.UpdatedAt,
  });

  AppConfigModel copyWith({
    int? Id,
    String? App_IOS_Version,
    String? Dashboard_IOS_Version,
    String? App_Android_Version,
    String? Dashboard_Android_Version,
    bool? AppEnabled,
    bool? DashboardEnabled,
    DateTime? CreatedAt,
    DateTime? UpdatedAt,
  }) {
    return AppConfigModel(
      Id: Id ?? this.Id,
      App_IOS_Version: App_IOS_Version ?? this.App_IOS_Version,
      Dashboard_IOS_Version:
          Dashboard_IOS_Version ?? this.Dashboard_IOS_Version,
      App_Android_Version: App_Android_Version ?? this.App_Android_Version,
      Dashboard_Android_Version:
          Dashboard_Android_Version ?? this.Dashboard_Android_Version,
      AppEnabled: AppEnabled ?? this.AppEnabled,
      DashboardEnabled: DashboardEnabled ?? this.DashboardEnabled,
      CreatedAt: CreatedAt ?? this.CreatedAt,
      UpdatedAt: UpdatedAt ?? this.UpdatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'App_IOS_Version': App_IOS_Version,
      'Dashboard_IOS_Version': Dashboard_IOS_Version,
      'App_Android_Version': App_Android_Version,
      'Dashboard_Android_Version': Dashboard_Android_Version,
      'AppEnabled': AppEnabled,
      'DashboardEnabled': DashboardEnabled,
      'CreatedAt': CreatedAt?.toString(),
      'UpdatedAt': UpdatedAt?.toString(),
    };
  }

  factory AppConfigModel.fromMap(Map<String, dynamic> map) {
    return AppConfigModel(
      Id: map['Id'] != null ? map['Id'] : null,
      App_IOS_Version:
          map['App_IOS_Version'] != null ? map['App_IOS_Version'] : null,
      Dashboard_IOS_Version: map['Dashboard_IOS_Version'] != null
          ? map['Dashboard_IOS_Version']
          : null,
      App_Android_Version: map['App_Android_Version'] != null
          ? map['App_Android_Version']
          : null,
      Dashboard_Android_Version: map['Dashboard_Android_Version'] != null
          ? map['Dashboard_Android_Version']
          : null,
      AppEnabled: map['AppEnabled'] != null ? map['AppEnabled'] : null,
      DashboardEnabled:
          map['DashboardEnabled'] != null ? map['DashboardEnabled'] : null,
      CreatedAt:
          map['CreatedAt'] != null ? DateTime.parse(map['CreatedAt']) : null,
      UpdatedAt:
          map['UpdatedAt'] != null ? DateTime.parse(map['UpdatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppConfigModel.fromJson(String source) =>
      AppConfigModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppConfigModel(Id: $Id, App_IOS_Version: $App_IOS_Version, Dashboard_IOS_Version: $Dashboard_IOS_Version, App_Android_Version: $App_Android_Version, Dashboard_Android_Version: $Dashboard_Android_Version, AppEnabled: $AppEnabled, DashboardEnabled: $DashboardEnabled, CreatedAt: $CreatedAt, UpdatedAt: $UpdatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppConfigModel &&
        other.Id == Id &&
        other.App_IOS_Version == App_IOS_Version &&
        other.Dashboard_IOS_Version == Dashboard_IOS_Version &&
        other.App_Android_Version == App_Android_Version &&
        other.Dashboard_Android_Version == Dashboard_Android_Version &&
        other.AppEnabled == AppEnabled &&
        other.DashboardEnabled == DashboardEnabled &&
        other.CreatedAt == CreatedAt &&
        other.UpdatedAt == UpdatedAt;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        App_IOS_Version.hashCode ^
        Dashboard_IOS_Version.hashCode ^
        App_Android_Version.hashCode ^
        Dashboard_Android_Version.hashCode ^
        AppEnabled.hashCode ^
        DashboardEnabled.hashCode ^
        CreatedAt.hashCode ^
        UpdatedAt.hashCode;
  }
}
