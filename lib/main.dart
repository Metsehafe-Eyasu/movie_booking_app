import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home_page.dart';
import './screens/movie_details_page.dart';
import './screens/seat_selection_page.dart';
import './screens/booking_confirmation_page.dart';
import './models/movie.dart';
import './models/seats.dart';

Future<List<Movie>> loadMovies() async {
  final jsonStr = await rootBundle.loadString('assets/data/movies.json');
  final decodedData = jsonDecode(jsonStr) as List<dynamic>;
  final movies = decodedData.map((data) => Movie.fromJson(data)).toList();
  return movies;
}

Future<Seats> fetchSeatData(int movieId, int showtimeIndex) async {
  final jsonData = await rootBundle.loadString('assets/data/seats.json');
  final data = jsonDecode(jsonData) as Map<String, dynamic>;
  final movies = data['movies'] as List<dynamic>;
  final movieData = movies.firstWhere((data) => data['movie_id'] == movieId);

  if (movieData == null) {
    throw Exception('Movie with ID $movieId not found in seats.json');
  }
  return Seats.fromJson(movieData);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(movies: await loadMovies()));
}

class MyApp extends StatelessWidget {
  final List<Movie> movies;

  const MyApp({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => HomePage(movies: movies),
        '/movie_details': (context) => _buildMovieDetailsPage(context),
        '/seat_selection': (context) => _buildSeatSelectionPage(context),
        '/booking_confirmation': (context) =>
            _buildBookingConfirmationPage(context),
      },
      initialRoute: '/',
    );
  }
}

Widget _buildMovieDetailsPage(BuildContext context) {
  final movie = ModalRoute.of(context)!.settings.arguments as Movie;
  return MovieDetailsPage(movie: movie);
}

Widget _buildSeatSelectionPage(BuildContext context) {
  final arguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final movieId = arguments['movieId'] as int;
  final showtimeIndex = arguments['showtimeIndex'] as int;
  final movie = arguments['movie'] as Movie;

  Future<Seats> seatDataFuture = fetchSeatData(movieId, showtimeIndex);

  return FutureBuilder<Seats>(
    future: seatDataFuture,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final seats = snapshot.data!;
        return SeatSelectionPage(
          seats: seats,
          movie: movie,
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Widget _buildBookingConfirmationPage(BuildContext context) {
  final arguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final seats = arguments['seats'] as List<Seat>;
  final movie = arguments['movie'] as Movie;
  return BookingConfirmationPage(selectedSeats: seats, movie: movie);
}
