import 'package:flutter/material.dart';

List<GenreInfo> getGridGenreCardsList() {
  return [
    const GenreInfo(
      image: 'assets/images/hiphop.jpeg',
      genre: 'Hip Hop',
      height: 120,
      color: Colors.red,
    ),
    const GenreInfo(
      image: 'assets/images/electronic.jpeg',
      genre: 'Electronic',
      height: 170,
      color: Colors.blue,
    ),
    const GenreInfo(
      image: 'assets/images/rock.jpeg',
      genre: 'Rock',
      height: 70,
      color: Colors.pinkAccent,
    ),
    const GenreInfo(
      image: 'assets/images/indie.jpeg',
      genre: 'Indie',
      height: 170,
      color: Colors.yellow,
    ),
    const GenreInfo(
      image: 'assets/images/latin.jpeg',
      genre: 'Latin',
      height: 220,
      color: Colors.orange,
    ),
  ];
}

class GenreInfo {
  final Color color;
  final String genre;
  final double height;
  final String image;
  const GenreInfo({
    required this.image,
    required this.color,
    required this.genre,
    required this.height,
  });
}
