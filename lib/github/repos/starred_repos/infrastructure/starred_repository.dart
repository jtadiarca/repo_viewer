import 'package:dartz/dartz.dart';

import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import 'starred_repos_remote_service.dart';

class StarredRepository {
  final StarredReposRemoteService _remoteService;
  // TODO: Local Service

  StarredRepository(this._remoteService);

  Future<Either<GithubFailure, List<GithubRepo>>> getStarredReposPage(
    int page,
  ) async {}
}
