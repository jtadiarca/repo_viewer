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
    void pushPageAndPutFirstInHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      // ref.read(searchHistoryNotifierProvider.notifier).putSearchTermFirst(searchTerm)
      context
          .read(searchHistoryNotifierProvider.notifier)
          .putSearchTermFirst(searchTerm);

      _controller.close();
    }

    void pushPageAndAddToHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      // ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(searchTerm)
      context
          .read(searchHistoryNotifierProvider.notifier)
          .addSearchTerm(searchTerm);

      _controller.close();
    }

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
      onQueryChanged: (query) {
        // ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms(filter: query);
        context
            .read(searchHistoryNotifierProvider.notifier)
            .watchSearchTerms(filter: query);
      },
      onSubmitted: (query) {
        pushPageAndAddToHistory(query);
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
                  if (_controller.query.isEmpty && history.value.isEmpty) {
                    return Container(
                      height: 56.0,
                      alignment: Alignment.center,
                      child: Text(
                        'Start Searching',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (history.value.isEmpty) {
                    return ListTile(
                      title: Text(_controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        pushPageAndAddToHistory(_controller.query);
                      },
                    );
                  }
                  return Column(
                    children: history.value
                        .map(
                          (term) => ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                // ref.read(searchHistoryNotifierProvider.notifier);
                                context
                                    .read(
                                        searchHistoryNotifierProvider.notifier)
                                    .deleteSearchTerm(term);
                              },
                            ),
                            onTap: () {
                              pushPageAndPutFirstInHistory(term);
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
