import 'package:repo_viewer/core/infrastructure/sembast_database.dart';
import 'package:repo_viewer/github/detail/infrastructure/github_repo_detail_dto.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

class RepoDetailLocalService {
  static const cacheSize = 50;

  final SembastDatabase _sembastDatabase;
  final _store = stringMapStoreFactory.store('repoDetails');

  RepoDetailLocalService(this._sembastDatabase);

  Future<void> upSertRepoDetail(GithubRepoDetailDto githubRepoDetailDto) async {
    await _store.record(githubRepoDetailDto.fullName).put(
          _sembastDatabase.instance,
          githubRepoDetailDto.toSembast(),
        );

    final keys = await _store.findKeys(_sembastDatabase.instance,
        finder: Finder(sortOrders: [
          SortOrder(GithubRepoDetailDto.lastUsedFieldName, false)
        ]));

    if (keys.length > cacheSize) {
      final keysToRemove = keys.sublist(cacheSize);
      for (final key in keysToRemove) {
        await _store.record(key).delete(_sembastDatabase.instance);
      }
    }
  }

  Future<GithubRepoDetailDto?> getRepoDetail(String fullRepoName) async {
    final record = _store.record(fullRepoName);
    await record.update(
      _sembastDatabase.instance,
      {GithubRepoDetailDto.lastUsedFieldName: Timestamp.now()},
    );

    final recordSnapshot = await record.getSnapshot(_sembastDatabase.instance);
    return (recordSnapshot == null)
        ? null
        : GithubRepoDetailDto.fromSembast(recordSnapshot);
  }
}
