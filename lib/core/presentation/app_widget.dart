import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/application/auth_notifier.dart';
import '../../auth/shared/providers.dart';
import '../shared/providers.dart';
import 'routes/app_router.gr.dart';

final initializationProvider = FutureProvider<Unit>((ref) async {
  await ref.read(sembastProvider).init();
  ref.read(dioProvider)
    ..options = BaseOptions(
      headers: {
        HttpHeaders.acceptHeader: 'application/vnd.github.v3.html+json',
      },
      validateStatus: (status) =>
          status != null &&
          status >= HttpStatus.ok &&
          status < HttpStatus.notFound,
    )
    ..interceptors.add(
      ref.read(oauth2InterceptorProvider),
    );
  final authNotifier = ref.read(authNotifierProvider.notifier);
  await authNotifier.checkAndUpdateAuthStatus();

  return unit;
});

class AppWidget extends ConsumerWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetReference ref) {
    /* ref.listen<AuthState>(authNotifier (state) {

    }); */

    return ProviderListener(
      provider: initializationProvider,
      onChange: (context, value) {},
      child: ProviderListener<AuthState>(
        provider: authNotifierProvider,
        onChange: (context, state) {
          state.maybeMap(
              orElse: () {},
              authenticated: (_) {
                appRouter.pushAndPopUntil(
                  const StarredReposRoute(),
                  predicate: (route) => false,
                );
              },
              unauthenticated: (_) {
                appRouter.pushAndPopUntil(
                  const SignInRoute(),
                  predicate: (route) => false,
                );
              });
        },
        child: MaterialApp.router(
          title: 'Repo Viewer',
          theme: _setupThemeData(),
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ),
    );
  }

  ThemeData _setupThemeData() {
    return ThemeData(
      primaryColor: Colors.grey.shade50,
    );
  }
}
