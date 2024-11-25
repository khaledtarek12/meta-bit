import 'dart:convert';

LoginVerification loginVerificationFromJson(String str) => LoginVerification.fromJson(json.decode(str));

String loginVerificationToJson(LoginVerification data) => json.encode(data.toJson());

class LoginVerification {
  LoginVerification({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  // Factory method to create an instance from JSON
  factory LoginVerification.fromJson(Map<String, dynamic> json) => LoginVerification(
        status: json["status"],
        message: json["message"],
      );

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}