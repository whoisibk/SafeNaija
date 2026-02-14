import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/modules/auth/repo/auth_repository.dart';

part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState());

  final AuthRepository _authRepository;

  void toggleAuthType() {
    emit(
      state.copyWith(
        type: state.type == AuthType.login ? AuthType.signUp : AuthType.login,
        errorMessage: null, // Clear error when switching
      ),
    );
  }

  Future<void> checkSession() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final response = await _authRepository.login(
        email: email,
        password: password,
      );
      await _authRepository.saveToken(response.accessToken);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _parseErrorMessage(e),
        ),
      );
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final response = await _authRepository.signup(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      await _authRepository.saveToken(response.accessToken);
      emit(state.copyWith(status: AuthStatus.authenticated));
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: _parseErrorMessage(e),
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
    } catch (_) {
      // Ignore logout errors from server, ensuring local cleanup happens
    }
    await _authRepository.deleteToken();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  String _parseErrorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data != null && data is Map<String, dynamic>) {
        if (data.containsKey('detail')) {
          return data['detail'].toString();
        } else if (data.containsKey('message')) {
          return data['message'].toString();
        }
      }
      if (data != null && data is String) {
        return data.length > 100 ? data.substring(0, 100) : data;
      }
      return error.message ?? 'An unknown error occurred';
    }
    return error.toString();
  }
}
