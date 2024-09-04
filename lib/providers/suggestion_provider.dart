import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/services/suggestion_service.dart';

class SuggestionsNotifier extends AsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() {
    return [];
  }

  final _suggestionsService = SuggestionService();
  Future<void> fetchSuggestions(String query) async {
    state = const AsyncValue.loading();
    final res = await _suggestionsService.getSuggestions(query);
    final val = res.match(
        (l) => state = AsyncValue.error(l, StackTrace.current),
        (r) => state = AsyncValue.data(r));

    log(val.toString());
  }
}

final suggestionsProvider =
    AsyncNotifierProvider<SuggestionsNotifier, List<String>>(() {
  return SuggestionsNotifier();
});

final queryProvider = StateProvider<String>((_) => '');
