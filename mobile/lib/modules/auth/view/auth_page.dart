import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/di/di.dart';
import 'package:mobile/common/widgets/widgets.dart';
import 'package:mobile/modules/auth/cubit/auth_cubit.dart';
import 'package:mobile/modules/auth/widgets/login_form.dart';
import 'package:mobile/modules/auth/widgets/signup_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLogin = state.type == AuthType.login;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'SafeNaija',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    isLogin ? 'Welcome back' : 'Create your account',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isLogin
                        ? 'Your safety, our priority.'
                        : 'Your safety, our priority.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Toggle
                  // Toggle
                  AppToggle(
                    labels: const ['Sign Up', 'Login'],
                    selectedIndex: isLogin ? 1 : 0,
                    onChanged: (index) {
                      if (index == 0 && isLogin) {
                        context.read<AuthCubit>().toggleAuthType();
                      } else if (index == 1 && !isLogin) {
                        context.read<AuthCubit>().toggleAuthType();
                      }
                    },
                  ),
                  const SizedBox(height: 32),

                  if (isLogin) const LoginForm() else const SignUpForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
