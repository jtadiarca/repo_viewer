import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

extension DtoListToDomainList on List<GithubRepoDto> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
