import 'package:flutter/material.dart';
import 'package:repo_viewer/search/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBar extends StatefulWidget /*ConsumerStatefulWidget*/ {
  const SearchBar({Key? key}) : super(key: key);

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
    return Container();
  }
}
