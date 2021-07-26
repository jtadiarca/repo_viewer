import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

class Oauth2Interceptor extends Interceptor {
  final GithubAuthenticator authenticator;

  Oauth2Interceptor(this.authenticator);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await authenticator.getSignedInCredentials();
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
        errorResponse.statusCode == HttpStatus.unauthorized) {}
  }
}
