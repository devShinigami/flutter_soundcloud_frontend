import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/components/genre_grid.dart';
import 'package:sound_cloud_clone/components/liked_textfield.dart';
import 'package:sound_cloud_clone/components/suggestions.dart';
import 'package:sound_cloud_clone/pages/search_detail.dart';
import 'package:sound_cloud_clone/providers/suggestion_provider.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  bool isFocused = false;
  Timer? _debounce;
  bool isSearchDetailVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(onFocusChanged);
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
    _searchController.dispose();
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
                      isSearchDetailVisible = false;
                      _searchController.clear();
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
          onSubmitted: (val) {
            if (val.isNotEmpty) {
              setState(() {
                isSearchDetailVisible = true;
                print(val);
                ref.read(queryProvider.notifier).state = val;
              });
            }
          },
          controller: _searchController,
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
      body: Stack(
        children: [
          AnimatedSwitcher(
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
                ? SuggestionScreen(
                    onToggle: () {
                      setState(() {
                        isSearchDetailVisible = true;
                        _focusNode.unfocus();
                        _searchController.text =
                            ref.watch(queryProvider.notifier).state;
                      });
                    },
                  )
                : const GenreGrid(),
          ),
          if (!isFocused && isSearchDetailVisible) const SearchDetail()
        ],
      ),
    );
  }
}
