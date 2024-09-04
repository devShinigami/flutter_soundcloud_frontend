import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/models/search.dart';
import 'package:sound_cloud_clone/providers/suggestion_provider.dart';
import 'package:sound_cloud_clone/services/search_services.dart';

class SearchNotifier extends AutoDisposeAsyncNotifier<SearchModel> {
  final SearchServices _searchServices = SearchServices();
  @override
  FutureOr<SearchModel> build() async {
    final query = ref.read(queryProvider.notifier).state;
    final res = await _searchServices.getSearchData(query);
    return res.match((l) {
      state = AsyncValue.error(l, StackTrace.current);
      throw l;
    }, (r) {
      state = AsyncValue.data(r);
      print(r);
      return r;
    });
  }
}

final searchProvider =
    AutoDisposeAsyncNotifierProvider<SearchNotifier, SearchModel>(
  () => SearchNotifier(),
);
