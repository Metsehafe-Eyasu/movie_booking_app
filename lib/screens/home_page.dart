import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_details_page.dart';

class HomePage extends StatelessWidget {
  final List<Movie> movies; // List of movies to display

  const HomePage({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieListItem(movie: movie);
        },
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.genre),
      leading: Image.asset(movie.posterImage),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movie: movie)),
        );
      },
    );
  }
}
