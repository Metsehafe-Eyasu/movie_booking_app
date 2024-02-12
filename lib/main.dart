import 'package:flutter/material.dart';

import './screens/home_page.dart';
import './screens/movie_details_page.dart';
import './screens/seat_selection_page.dart';
import './screens/booking_confirmation_page.dart';
import './screens/booked_seats_page.dart';

import './models/movie.dart';
import './models/seats.dart';
import './utils/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(movies: movies));
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
        '/booked_seats': (context) => const BookedSeatsScreen(),
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
  final showtimeIndex = arguments['showtimeIndex'] as int;
  final movie = arguments['movie'] as Movie;

  Seats seats = fetchSeatData(movie, showtimeIndex);

  return SeatSelectionPage(
    seats: seats,
    movie: movie,
    showtimeIndex: showtimeIndex
  );
}

Widget _buildBookingConfirmationPage(BuildContext context) {
  final arguments =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  final seats = arguments['seats'] as List<Seat>;
  final movie = arguments['movie'] as Movie;
  final timeSlotId = arguments['timeSlotId'] as int;
  return BookingConfirmationPage(selectedSeats: seats, movie: movie, timeSlotId: timeSlotId);
}
