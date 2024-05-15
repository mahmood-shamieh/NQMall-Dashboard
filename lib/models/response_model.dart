import 'dart:convert';

class ResponseModel {
  int? code;
  String? message;
  dynamic data;
  ResponseModel({
    this.code,
    this.message,
    required this.data,
  });
  factory ResponseModel.connectionTimeOut() {
    return ResponseModel(code: 1, message: 'Connection timeout', data: null);
  }
  factory ResponseModel.noInternetConnection() {
    return ResponseModel(
        code: 2, message: 'No Internet connection', data: null);
  }
  factory ResponseModel.serverProblemError() {
    return ResponseModel(
        code: 0,
        message: 'Server error, please contact the support Team',
        data: null);
  }

  ResponseModel copyWith({
    int? code,
    String? message,
    dynamic? data,
  }) {
    return ResponseModel(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      code: map['code'] != null ? map['code'] : null,
      message: map['message'] != null ? map['message'] : null,
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseModel(code: $code, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseModel &&
        other.code == code &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}
