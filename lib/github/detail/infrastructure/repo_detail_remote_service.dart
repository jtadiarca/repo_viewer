import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers_cache.dart';

class RepoDetailRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  RepoDetailRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<String>> getReadmeHtml(String fullRepoName) async {
    final requestUri = Uri.https(
      'api.github.com',
      '/repos/$fullRepoName/readme',
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            HttpHeaders.ifNoneMatchHeader: previousHeaders?.etag ?? '',
          },
          responseType: ResponseType.plain,
        ),
      );

      switch (response.statusCode) {
        case HttpStatus.notModified:
          return const RemoteResponse.notModified(maxPage: 0);

        case HttpStatus.ok:
          final headers = GithubHeaders.parse(response);

          await _headersCache.saveHeaders(requestUri, headers);
          final html = response.data as String;
          return RemoteResponse.withNewData(html, maxPage: 0);

        default:
          throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else {
        rethrow;
      }
    }
  }
}
