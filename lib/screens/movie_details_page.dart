import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: movie.id,
                child: Image.asset(movie.posterImage),
              ),
              const SizedBox(height: 20.0),
              Text(
                movie.genre,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Release Year: ${movie.releaseYear}",
                style: const TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Synopsis:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Movie synopsis goes here...",
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Showtimes:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/seat_selection', arguments: {
                      'movieId': movie.id,
                      'showtimeIndex': index,
                      'movie': movie,
                    });
                  },
                  child: Text(movie.showtimes[index]),
                ),
                itemCount: movie.showtimes.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
