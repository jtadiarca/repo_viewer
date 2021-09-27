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
  late FloatingSearchBarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    // ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms();
    Future.microtask(
      () => context
          .read(searchHistoryNotifierProvider.notifier)
          .watchSearchTerms(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: _controller,
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
      onSubmitted: (query) {
        widget.onShouldNavigateToResultPage(query);
        // ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(query)
        context
            .read(searchHistoryNotifierProvider.notifier)
            .addSearchTerm(query);

        _controller.close();
      },
      builder: (context, transition) {
        return Material(
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.hardEdge,
          color: Theme.of(context).cardColor,
          elevation: 4,
          child: Consumer(
            builder: (context, ref, child) {
              final searchHistoryState =
                  ref.watch(searchHistoryNotifierProvider);
              return searchHistoryState.map(
                data: (history) {
                  return Column(
                    children: history.value
                        .map(
                          (term) => ListTile(
                            title: Text(term),
                            onTap: () {
                              print('hey');
                            },
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
          ),
        );
      },
    );
  }
}
