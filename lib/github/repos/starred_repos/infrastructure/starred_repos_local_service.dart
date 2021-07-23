import 'package:collection/collection.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/infrastructure/sembast_database.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

class StarredReposLocalService {
  final SembastDatabase _sembastDatabase;
  final _store = intMapStoreFactory.store('starredRepos');

  StarredReposLocalService(this._sembastDatabase);

  Future<void> insertPage() async {}

  Future<void> upsertPage(List<GithubRepoDto> dtos, int page) async {
    final sembastPage = page - 1;

    await _store
        .records(dtos.mapIndexed((index, _) => index + 3 * sembastPage))
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
        );
  }
}
