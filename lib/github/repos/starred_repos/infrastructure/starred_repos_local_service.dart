import 'package:collection/collection.dart';
import 'package:repo_viewer/github/core/infrastructure/pagination_config.dart';
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
        .records(
          dtos.mapIndexed((index, _) =>
              index + PaginationConfig.itemsPerPage * sembastPage),
        )
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
        );
  }

  Future<List<GithubRepoDto>> getPage(int page) async {
    final sembastPage = page - 1;

    final records = await _store.find(
      _sembastDatabase.instance,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: PaginationConfig.itemsPerPage * sembastPage,
      ),
    );

    return records.map((e) => GithubRepoDto.fromJson(e.value)).toList();
  }
}
