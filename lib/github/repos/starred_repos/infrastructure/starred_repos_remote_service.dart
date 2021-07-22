import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';

import '../../../../core/infrastructure/dio_extensions.dart';
import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  StarredReposRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<List<GithubRepoDto>>> getStarredReposPage(
    int page,
  ) async {
    final token = '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';
    final accept = 'application/vnd.github.v3.html+json';
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {'page': '$page'},
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $token',
            HttpHeaders.acceptHeader: accept,
            HttpHeaders.ifNoneMatchHeader: previousHeaders?.etag ?? '',
          },
        ),
      );
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
