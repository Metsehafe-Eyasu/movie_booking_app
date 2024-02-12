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
      body: GridView.count(
        crossAxisCount: 2, // Two movies per row
        childAspectRatio: 0.6, // Adjust aspect ratio of each card
        mainAxisSpacing: 10.0, // Add spacing between cards
        crossAxisSpacing: 10.0,
        children: movies
            .map((movie) => MovieListItem(movie: movie))
            .toList(), // Create a list of MovieListItem widgets
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
            context, '/booked_seats'), // Route to booked seats screen
        label: const Text('Booked Seats'),
        icon: const Icon(Icons.bookmark),
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(movie: movie),
                  ),
                );
              },
              child: Image.asset(
                movie.posterImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.genre,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
