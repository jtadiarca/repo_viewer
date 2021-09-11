import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/domain/github_failure.dart';
import 'paginated_repos_list_view.dart';

class FailureRepoTile extends ConsumerWidget {
  final GithubFailure failure;

  const FailureRepoTile({
    Key? key,
    required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetReference ref) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      iconColor: Theme.of(context).colorScheme.onError,
      child: Card(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          title: Text('An error occured, please retry'),
          subtitle: Text(
            failure.map(api: (_) => 'API returned ${_.httpStatus}'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const SizedBox(
            height: double.infinity,
            child: Icon(Icons.warning),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // ref.read(starredReposNotifierProvider.notifier).getNextStarredReposPage()
              context
                  .findAncestorWidgetOfExactType<PaginatedReposListView>()
                  ?.getNextPage(/*ref*/ context);
            },
          ),
        ),
      ),
    );
  }
}
