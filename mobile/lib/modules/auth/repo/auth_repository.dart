import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/modules/auth/models/login_response.dart';
import 'package:mobile/modules/auth/models/signup_request.dart';
import 'package:mobile/modules/auth/models/signup_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });

  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();

  Future<bool> isLoggedIn();

  Future<void> logout();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio, this._storage);

  final Dio _dio;
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'auth_token';

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/login',
      data: {
        'grant_type': '',
        'username': email,
        'password': password,
        'scope': '',
        'client_id': '',
        'client_secret': '',
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<SignupResponse> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    // Generate username from email (e.g., johndoe@gmail.com -> johndoe_123456789)
    final usernamePrefix = email.split('@').first;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final username = '${usernamePrefix}_$timestamp';

    final request = SignupRequest(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
    );

    final response = await _dio.post(
      '/signup',
      data: request.toJson(),
    );

    return SignupResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  @override
  Future<void> logout() async {
    await _dio.post<void>('/logout');
  }
}
