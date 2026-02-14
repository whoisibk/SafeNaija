part of 'auth_cubit.dart';

enum AuthType { login, signUp }

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  const AuthState({
    this.type = AuthType.login,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  final AuthType type;
  final AuthStatus status;
  final String? errorMessage;

  AuthState copyWith({
    AuthType? type,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      type: type ?? this.type,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [type, status, errorMessage];
}
