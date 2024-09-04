import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/all_search.dart';
import 'package:sound_cloud_clone/providers/search_provider.dart';

class SearchDetail extends ConsumerStatefulWidget {
  const SearchDetail({super.key});

  @override
  ConsumerState<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends ConsumerState<SearchDetail> {
  @override
  Widget build(BuildContext context) {
    final searchAsyncValue = ref.watch(searchProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 5,
          child: searchAsyncValue.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              data: (search) => Column(
                    children: [
                      TabBar(
                        enableFeedback: false,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.secondary,
                        tabAlignment: TabAlignment.start,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        dividerHeight: 0,
                        isScrollable: true,
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'Tracks'),
                          Tab(text: 'Playlist'),
                          Tab(text: 'Users'),
                          Tab(text: 'Albums'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: TabBarView(
                          children: [
                            AllSearch(
                              searchModel: search,
                            ),
                            Center(child: Text('Tracks content')),
                            Center(child: Text('Playlist content')),
                            Center(child: Text('Users content')),
                            Center(child: Text('Albums content')),
                          ],
                        ),
                      ),
                    ],
                  ),
              error: (error, stackTrace) {
                print(error);
                return Center(
                  child: Text('Oopsie! Some error occurred...'),
                );
              }),
        ),
      ),
    );
  }
}
