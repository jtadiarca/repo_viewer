import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repo_viewer/github/core/shared/providers.dart';

import '../../../../auth/shared/providers.dart';

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
      appBar: AppBar(
        title: Text('Starred repos'),
        actions: [
          IconButton(
            icon: const Icon(MdiIcons.logoutVariant),
            onPressed: () {
              // ref.read(authNotifierProvider.notifier).signOut()
              context.read(authNotifierProvider.notifier).signOut();
            },
          )
        ],
      ),
      body: PaginatedReposListView(),
    );
  }
}

class PaginatedReposListView extends StatelessWidget {
  const PaginatedReposListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
