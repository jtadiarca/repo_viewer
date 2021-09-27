import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../shared/providers.dart';

class SearchBar extends StatefulWidget /*ConsumerStatefulWidget */ {
  final Widget body;
  final String title, hint;
  final void Function(String searchTerm) onShouldNavigateToResultPage;
  final void Function() onSignOutButtonPressed;

  const SearchBar({
    Key? key,
    required this.body,
    required this.title,
    required this.hint,
    required this.onShouldNavigateToResultPage,
    required this.onSignOutButtonPressed,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> /*ConsumerState<SearchBar>*/ {
  @override
  void initState() {
    super.initState();
    // ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms();
    Future.microtask(
      () => context
          .read(searchHistoryNotifierProvider.notifier)
          .watchSearchTerms(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      body: FloatingSearchBarScrollNotifier(
        child: widget.body,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'Tap to search 👆',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      hint: widget.hint,
      actions: [
        FloatingSearchBarAction.searchToClear(showIfClosed: false),
        FloatingSearchBarAction(
          child: IconButton(
            icon: Icon(MdiIcons.logoutVariant),
            splashRadius: 18,
            onPressed: () {
              widget.onSignOutButtonPressed();
            },
          ),
        )
      ],
      builder: (context, transition) {
        return Consumer(
          builder: (context, ref, child) {
            final searchHistoryState = ref.watch(searchHistoryNotifierProvider);
            return searchHistoryState.map(
              data: (history) {
                return Column(
                  children: history.value
                      .map(
                        (term) => ListTile(
                          title: Text(term),
                        ),
                      )
                      .toList(),
                );
              },
              loading: (_) => const ListTile(
                title: LinearProgressIndicator(),
              ),
              error: (_) => ListTile(
                title: Text('Unexpected error ${_.error}'),
              ),
            );
          },
        );
      },
    );
  }
}
