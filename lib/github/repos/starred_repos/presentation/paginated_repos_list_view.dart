import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/core/presentation/toasts.dart';
import 'package:repo_viewer/github/core/presentation/no_results_display.dart';

import '../../../core/shared/providers.dart';
import '../application/starred_repos_notifier.dart';
import 'failure_repo_tile.dart';
import 'loading_repo_tile.dart';
import 'repo_tile.dart';

class PaginatedReposListView extends StatefulWidget {
  const PaginatedReposListView({
    Key? key,
  }) : super(key: key);

  @override
  _PaginatedReposListViewState createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState extends State<PaginatedReposListView> {
  bool canLoadNextPage = false;
  bool hasShownNoConnectionToast = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // ref.listen<StarredReposState>(starredReposNotifierProvider, (state) {},);

        final state = ref.watch(starredReposNotifierProvider);
        return ProviderListener<StarredReposState>(
          provider: starredReposNotifierProvider,
          onChange: (context, state) {
            state.map(
              initial: (_) => canLoadNextPage = true,
              loadInProgress: (_) => canLoadNextPage = false,
              loadSuccess: (_) {
                if (!_.repos.isFresh && !hasShownNoConnectionToast) {
                  hasShownNoConnectionToast = true;
                  showNoConnectionToast(
                      "You're not online. Some information maybe outdated.",
                      context);
                }
                return canLoadNextPage = _.isNextPageAvailable;
              },
              loadFailure: (_) => canLoadNextPage = false,
            );
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final metrics = notification.metrics;
              final limit =
                  metrics.maxScrollExtent - metrics.viewportDimension / 3;

              if (canLoadNextPage && metrics.pixels >= limit) {
                canLoadNextPage = false;
                // ref
                //     .read(starredReposNotifierProvider.notifier)
                //     .getNextStarredReposPage();

                context
                    .read(starredReposNotifierProvider.notifier)
                    .getNextStarredReposPage();
              }
              return false;
            },
            child: state.maybeWhen(
                    loadSuccess: (repos, _) => repos.entity.isEmpty,
                    orElse: () => false)
                ? const NoResultsDisplay(
                    message:
                        "That's about everything we could find in your starred repos right now.",
                  )
                : _PaginatedListView(state: state),
          ),
        );
      },
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final StarredReposState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.map(
        initial: (_) => 0,
        loadInProgress: (_) => _.repos.entity.length + _.itemsPerPage,
        loadSuccess: (_) => _.repos.entity.length,
        loadFailure: (_) => _.repos.entity.length + 1,
      ),
      itemBuilder: (context, index) {
        return state.map(
          initial: (_) => RepoTile(repo: _.repos.entity[index]),
          loadInProgress: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(repo: _.repos.entity[index]);
            } else {
              return const LoadingRepoTile();
            }
          },
          loadSuccess: (_) => RepoTile(
            repo: _.repos.entity[index],
          ),
          loadFailure: (_) {
            if (index < _.repos.entity.length) {
              return RepoTile(repo: _.repos.entity[index]);
            } else {
              return FailureRepoTile(failure: _.failure);
            }
          },
        );
      },
    );
  }
}
