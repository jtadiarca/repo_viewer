import 'package:dartz/dartz.dart';

import '../../../../core/domain/fresh.dart';
import '../../../../core/infrastructure/network_exceptions.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/github_repo_dto.dart';
import 'starred_repos_remote_service.dart';

class StarredRepository {
  final StarredReposRemoteService _remoteService;
  // TODO: Local Service

  StarredRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
    int page,
  ) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);

      return right(
        remotePageItems.when(
          // TODO: Local Service
          noConnection: (maxPage) => Fresh.no(
            [],
            isNextPageAvailable: page < maxPage,
          ),
          // TODO: Local Service
          notModified: (maxPage) => Fresh.yes(
            [],
            isNextPageAvailable: page < maxPage,
          ),
          withNewData: (data, maxPage) {
            // TODO: save data into the local service
            return Fresh.yes(
              data.toDomain(),
              isNextPageAvailable: page < maxPage,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return Left(GithubFailure.api(e.errorCode));
    }
  }
}

extension DtoListToDomainList on List<GithubRepoDto> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
