import 'seats.dart';

class Movie {
  final int id;
  final String title;
  final String genre;
  final int releaseYear;
  final String posterImage;
  final List<String> showtimes;
  final Map<int, Seats> seats;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.releaseYear,
    required this.posterImage,
    required this.showtimes,
    required this.seats,
  });

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     id: json['id'] as int,
  //     title: json['title'] as String,
  //     genre: json['genre'] as String,
  //     releaseYear: json['release_year'] as int,
  //     posterImage: json['poster_image'] as String,
  //     showtimes: List<String>.from(json['showtimes']),
  //     seats: (json['seats'] as Map<String, dynamic>).map((key, value) {
  //       return MapEntry(int.parse(key), Seats.fromJson(value));
  //     }),
  //   );
  // }
}
