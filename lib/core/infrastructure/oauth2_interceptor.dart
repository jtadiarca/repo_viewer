import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repo_viewer/auth/application/auth_notifier.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

class Oauth2Interceptor extends Interceptor {
  final GithubAuthenticator _authenticator;
  final AuthNotifier _authNotifier;
  final Dio _dio;

  Oauth2Interceptor(this._authenticator, this._authNotifier, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await _authenticator.getSignedInCredentials();
    final modifiedOptions = options
      ..headers.addAll(
        credentials == null
            ? {}
            : {
                HttpHeaders.authorizationHeader:
                    'bearer ${credentials.accessToken}'
              },
      );
    handler.next(modifiedOptions);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;
    if (errorResponse != null &&
        errorResponse.statusCode == HttpStatus.unauthorized) {
      final credentials = await _authenticator.getSignedInCredentials();

      credentials != null && credentials.canRefresh
          ? await _authenticator.refresh(credentials)
          : await _authenticator.clearCredentialsStorage();

      await _authNotifier.checkAndUpdateAuthStatus();

      final refreshCredentials = await _authenticator.getSignedInCredentials();
      if (refreshCredentials != null) {
        handler.resolve(
          await _dio.fetch(
            errorResponse.requestOptions
              ..headers[HttpHeaders.authorizationHeader] =
                  'bearer $refreshCredentials',
          ),
        );
      }
    } else {
      handler.next(err);
    }
  }
}
