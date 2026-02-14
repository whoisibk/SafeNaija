import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable()
class SignupRequest extends Equatable {
  const SignupRequest({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  @JsonKey(name: 'first_name')
  final String firstName;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String username;
  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  @override
  List<Object> get props => [firstName, lastName, username, email, password];
}
