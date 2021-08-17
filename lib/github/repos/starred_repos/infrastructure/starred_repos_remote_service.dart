import 'dart:io';

import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/core/infrastructure/github_headers.dart';
import 'package:repo_viewer/github/core/infrastructure/pagination_config.dart';

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
    final requestUri = Uri.https(
      'api.github.com',
      '/user/starred',
      {
        'page': '$page',
        'per_page': PaginationConfig.itemsPerPage.toString(),
      },
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            HttpHeaders.ifNoneMatchHeader: previousHeaders?.etag ?? '',
          },
        ),
      );

      switch (response.statusCode) {
        case HttpStatus.notModified:
          return RemoteResponse.notModified(
            maxPage: previousHeaders?.link?.maxPage ?? 0,
          );

        case HttpStatus.ok:
          final headers = GithubHeaders.parse(response);

          await _headersCache.saveHeaders(requestUri, headers);

          final convertedData = (response.data as List<dynamic>)
              .map((e) => GithubRepoDto.fromJson(e as Map<String, dynamic>))
              .toList();

          return RemoteResponse.withNewData(
            convertedData,
            maxPage: headers.link?.maxPage ?? 1,
          );

        default:
          throw RestApiException(response.statusCode);
      }
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
