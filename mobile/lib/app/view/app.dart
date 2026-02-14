import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/router/app_router.dart';
import 'package:mobile/common/di/di.dart';
import 'package:mobile/common/services/overlay_service.dart';
import 'package:mobile/common/theme/app_theme.dart';
import 'package:mobile/l10n/l10n.dart';
import 'package:mobile/modules/auth/cubit/auth_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthCubit _authCubit;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>()..checkSession();
    final overlayService = getIt<OverlayService>();
    _appRouter = AppRouter(_authCubit, overlayService.navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: MaterialApp.router(
        routerConfig: _appRouter.router,
        theme: AppTheme.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
