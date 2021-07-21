import 'package:dio/dio.dart';

import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;

  StarredReposRemoteService(this._dio);

  // Future<RemoteResponse<List<GithubRepoDto>>> getStarredReposPage(
  //   int page,
  // ) async {
  //   // _dio.get(path)
  // }
}
