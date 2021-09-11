import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/shared/providers.dart';
import '../application/search_history_notifier.dart';
import '../infrastructure/search_history_repository.dart';

final searchHistoryRepositoryProvider = Provider(
  (ref) => SearchHistoryRepository(
    ref.watch(sembastProvider),
  ),
);

final searchHistoryNotifierProvider =
    StateNotifierProvider<SearchHistoryNotifier, AsyncValue<List<String>>>(
  (ref) => SearchHistoryNotifier(
    ref.watch(searchHistoryRepositoryProvider),
  ),
);
