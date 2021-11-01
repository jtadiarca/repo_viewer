import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/core/domain/github_failure.dart';
import 'package:repo_viewer/github/detail/domain/github_repo_detail.dart';
import 'package:repo_viewer/github/detail/infrastructure/repo_detail_local_service.dart';
import 'package:repo_viewer/github/detail/infrastructure/repo_detail_remote_service.dart';

class RepoDetailRepository {
  final RepoDetailLocalService _localService;
  final RepoDetailRemoteService _remoteService;

  RepoDetailRepository(this._localService, this._remoteService);

  /// Returns `right(null)` if there's no Internet connection
  Future<Either<GithubFailure, Unit?>> switchStarredStatus(
    GithubRepoDetail repoDetail,
  ) async {
    try {
      final actionCompleted = await _remoteService.switchStarredStatus(
        repoDetail.fullName,
        isCurrentlyStarred: repoDetail.starred,
      );

      return right(actionCompleted);
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}
