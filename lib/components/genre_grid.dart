import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sound_cloud_clone/utils/genre_cards.dart';

class GenreGrid extends StatefulWidget {
  const GenreGrid({super.key});

  @override
  State<GenreGrid> createState() => _GenreGridState();
}

class _GenreGridState extends State<GenreGrid> {
  final _genreList = getGridGenreCardsList();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
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
    );
  }
}
