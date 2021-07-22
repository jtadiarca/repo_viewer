import 'package:dio/dio.dart';

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
    _dio.get('');
  }
}
