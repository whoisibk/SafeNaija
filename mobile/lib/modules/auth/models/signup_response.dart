// Re-using LoginResponse structure or creating a separate one if needed.
// Based on the prompt, the response for signup is similar:
// {
//     "status": 200,
//     "access_token": "...",
//     "token_type": "Bearer"
// }
// So we can arguably re-use LoginResponse or create a specific SignupResponse.
// I will create a specific one for clarity and extensibility.

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse extends Equatable {
  const SignupResponse({
    required this.accessToken,
    required this.tokenType,
    this.status,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'token_type')
  final String tokenType;

  final int? status;

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);

  @override
  List<Object?> get props => [accessToken, tokenType, status];
}
