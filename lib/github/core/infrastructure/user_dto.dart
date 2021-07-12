import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();
  const factory UserDto({
    required String name,
    required Uri avatarUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['login'] as String,
      avatarUrl: Uri.parse(json['avatar_url'] as String),
    );
  }
}
