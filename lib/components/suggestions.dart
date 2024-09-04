import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sound_cloud_clone/providers/suggestion_provider.dart';
import 'package:sound_cloud_clone/utils/highlighted_text.dart';

class SuggestionScreen extends ConsumerStatefulWidget {
  const SuggestionScreen({super.key});

  @override
  ConsumerState<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends ConsumerState<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    final suggestions = ref.watch(suggestionsProvider);
    final queryState = ref.watch(queryProvider);
    return Scaffold(
      body: suggestions.when(
        data: (data) {
          if (queryState.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: buildHighlightedText(
                    context: context,
                    fullText: data[index],
                    query: queryState,
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
        loading: () {
          return null;
        },
        error: (err, stack) => Center(
          child: Text(
            'OOps! Something went wrong. Try again later.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
