// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepoDto _$_$_GithubRepoDtoFromJson(Map<String, dynamic> json) {
  return _$_GithubRepoDto(
    owner: UserDto.fromJson(json['owner'] as Map<String, dynamic>),
    name: json['name'] as String,
    description: _descriptionFromJson(json['description']),
    stargazersCount: json['stargazers_count'] as int,
  );
}

Map<String, dynamic> _$_$_GithubRepoDtoToJson(_$_GithubRepoDto instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'name': instance.name,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
    };
