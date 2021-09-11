import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../auth/shared/providers.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../search/presentation/search_bar.dart';
import '../../../core/shared/providers.dart';
import '../../core/presentation/paginated_repos_list_view.dart';

class StarredReposPage extends StatefulWidget {
  const StarredReposPage({Key? key}) : super(key: key);

  @override
  _StarredReposPageState createState() => _StarredReposPageState();
}

class _StarredReposPageState extends State<StarredReposPage> {
  // Soon extend ConsumerStatefulWidget

  @override
  void initState() {
    super.initState();

    //ref.read(starredReposNotifierProvider.notifier).getNextStarredReposPage()
    Future.microtask(
      () => context
          .read(starredReposNotifierProvider.notifier)
          .getNextStarredReposPage(),
    );

    //Alternative to Future.microtask - WidgetsBinding.instance?.addPostFrameCallback((timesStamp) {})
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar(
        title: 'Starred repositories',
        hint: 'Search all repositories...',
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context)
              .push(SearchedReposRoute(searchTerm: searchTerm));
        },
        onSignOutButtonPressed: () {
          // ref.read(authNotifierProvider.notifier).signOut()
          context.read(authNotifierProvider.notifier).signOut();
        },
        body: PaginatedReposListView(
          paginatedReposNotifierProvider: starredReposNotifierProvider,
          getNextPage: (/*ref*/ context) {
            // ref
            //     .read(starredReposNotifierProvider.notifier)
            //     .getNextStarredReposPage();

            context
                .read(starredReposNotifierProvider.notifier)
                .getNextStarredReposPage();
          },
          noResultsMessage:
              "That's about everything we could find in your starred repos right now.",
        ),
      ),
    );
  }
}
