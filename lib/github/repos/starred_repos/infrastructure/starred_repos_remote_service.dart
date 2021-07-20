import 'package:dio/dio.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;

  StarredReposRemoteService(this._dio);

  Future<List<GithubRepoDto>> getStarredReposPage(
    int page,
  ) async {}
}
