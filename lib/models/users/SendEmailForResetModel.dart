import 'dart:convert';

SendEmailForReset sendEmailForResetFromJson(String str) =>
    SendEmailForReset.fromJson(json.decode(str));

String sendEmailForResetToJson(SendEmailForReset data) =>
    json.encode(data.toJson());

class SendEmailForReset {
  String email;

  SendEmailForReset({required this.email});

  factory SendEmailForReset.fromJson(Map<String, dynamic> json) =>
      SendEmailForReset(email: json["email"]);

  Map<String, dynamic> toJson() => {"email": email};
}
