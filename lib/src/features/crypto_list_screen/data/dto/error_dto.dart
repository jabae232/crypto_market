// To parse this JSON data, do
//
//     final errorDto = errorDtoFromJson(jsonString);

import 'dart:convert';

ErrorDto errorDtoFromJson(String str) => ErrorDto.fromJson(json.decode(str));

class ErrorDto {
  final String? status;
  final String? requestId;
  final String? message;
  final String? error;
  ErrorDto({
    required this.status,
    required this.requestId,
    required this.message,
    required this.error
  });

  factory ErrorDto.fromJson(Map<String, dynamic> json) => ErrorDto(
    status: json["status"] ?? '',
    requestId: json["request_id"] ?? '',
    message: json["message"] ?? '',
    error: json["error"] ?? '',
  );
}
