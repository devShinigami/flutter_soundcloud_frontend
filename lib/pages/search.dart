import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/liked_textfield.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sound_cloud_clone/components/suggestions.dart';
import 'package:sound_cloud_clone/providers/suggestion_provider.dart';
import 'package:sound_cloud_clone/utils/genre_cards.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final _genreList = getGridGenreCardsList();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(onFocusChanged);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _focusNode.unfocus();
      }
    });
  }

  void onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode.removeListener(onFocusChanged);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsNotifier = ref.read(suggestionsProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: isFocused
            ? [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _focusNode.unfocus();
                    });
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ]
            : null,
        title: LikedTrackSearchField(
          onChanged: (val) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              if (val.isNotEmpty) {
                suggestionsNotifier.fetchSuggestions(val);
              }
              ref.read(queryProvider.notifier).state = val;
            });
          },
          focusNode: _focusNode,
          fillColor: const Color.fromARGB(255, 64, 63, 63),
        ),
      ),
      body: AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            )
                .chain(
                  CurveTween(curve: Curves.fastLinearToSlowEaseIn),
                )
                .animate(animation),
            child: child,
          );
        },
        duration: const Duration(
          milliseconds: 200,
        ),
        child: isFocused
            ? const SuggestionScreen()
            : MasonryGridView.count(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: _genreList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: _genreList[index].height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: _genreList[index].color,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: AssetImage(_genreList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Theme.of(context).primaryColor,
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              _genreList[index].genre,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
