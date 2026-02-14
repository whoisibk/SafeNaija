// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/auth/cubit/auth_cubit.dart' as _i655;
import '../../modules/auth/repo/auth_repository.dart' as _i693;
import '../network/di/network_module.dart' as _i279;
import '../network/interceptors/api_interceptor.dart' as _i150;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../services/overlay_service.dart' as _i946;
import 'storage_module.dart' as _i371;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i150.ApiInterceptor>(() => _i150.ApiInterceptor());
    gh.factory<_i511.ErrorInterceptor>(() => _i511.ErrorInterceptor());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i946.OverlayService>(() => _i946.OverlayService());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i150.ApiInterceptor>(),
        gh<_i511.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i693.AuthRepository>(
      () => _i693.AuthRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i655.AuthCubit>(
      () => _i655.AuthCubit(gh<_i693.AuthRepository>()),
    );
    return this;
  }
}

class _$StorageModule extends _i371.StorageModule {}

class _$NetworkModule extends _i279.NetworkModule {}
