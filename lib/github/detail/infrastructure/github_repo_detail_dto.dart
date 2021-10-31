import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/github/detail/domain/github_repo_detail.dart';
import 'package:sembast/sembast.dart';

part 'github_repo_detail_dto.freezed.dart';
part 'github_repo_detail_dto.g.dart';

@freezed
class GithubRepoDetailDto with _$GithubRepoDetailDto {
  const GithubRepoDetailDto._();
  const factory GithubRepoDetailDto({
    required String fullName,
    required String html,
    required bool starred,
  }) = _GithubRepoDetailDto;

  factory GithubRepoDetailDto.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDetailDtoFromJson(json);

  GithubRepoDetail toDomain() => GithubRepoDetail(
        fullName: fullName,
        html: html,
        starred: starred,
      );

  Map<String, dynamic> toSembast() {
    final json = toJson();
    json.remove('fullName');
    return json;
  }

  factory GithubRepoDetailDto.fromSembast(
    RecordSnapshot<String, Map<String, dynamic>> snapshot,
  ) {
    final copiedMap = Map<String, dynamic>.from(snapshot.value);
    copiedMap['fullName'] = snapshot.key;
    return GithubRepoDetailDto.fromJson(copiedMap);
  }
}
