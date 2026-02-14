import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/utils/go_router_refresh_stream.dart';
import 'package:mobile/app/view/splash_page.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/auth/cubit/auth_cubit.dart';
import 'package:mobile/modules/home/view/home_page.dart';
import 'package:mobile/modules/onboarding/onboarding.dart';

class AppRouter {
  AppRouter(this._authCubit, this.navigatorKey);

  final AuthCubit _authCubit;
  final GlobalKey<NavigatorState> navigatorKey;

  late final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/onboarding',
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final authState = _authCubit.state;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isInitial = authState.status == AuthStatus.initial;
      final isLoggingIn = state.uri.path == '/auth';
      final isOnboarding = state.uri.path == '/onboarding';
      final isSplash = state.uri.path == '/splash';

      if (isInitial) {
        return '/splash';
      }

      if (isSplash && !isInitial && !isAuthenticated) {
        return '/onboarding';
      }

      if (isAuthenticated) {
        // If authenticated and trying to access auth or onboarding or splash, go to home
        if (isLoggingIn || isOnboarding || isSplash) {
          return '/home';
        }
      } else {
        // If not authenticated and trying to access home, go to auth
        // Also allow onboarding
        if (state.uri.path == '/home') {
          return '/auth';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
