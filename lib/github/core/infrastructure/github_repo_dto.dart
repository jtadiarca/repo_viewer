import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/github/core/domain/github_repo.dart';

import 'user_dto.dart';

part 'github_repo_dto.freezed.dart';
part 'github_repo_dto.g.dart';

String _descriptionFromJson(Object? json) {
  return (json as String?) ?? '';
}

@freezed
class GithubRepoDto with _$GithubRepoDto {
  const GithubRepoDto._();
  const factory GithubRepoDto({
    required UserDto owner,
    required String name,
    @JsonKey(fromJson: _descriptionFromJson) required String description,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
  }) = _GithubRepoDto;

  factory GithubRepoDto.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDtoFromJson(json);

  factory GithubRepoDto.fromDomain(GithubRepo _) {
    return GithubRepoDto(
      owner: UserDto.fromDomain(_.owner),
      name: _.name,
      description: _.description,
      stargazersCount: _.stargazersCount,
    );
  }

  GithubRepo toDomain() {
    return GithubRepo(
      owner: owner.toDomain(),
      name: name,
      description: description,
      stargazersCount: stargazersCount,
    );
  }
}
