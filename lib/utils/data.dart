import '../models/movie.dart';
import '../models/seats.dart';
import '../models/booked_seats.dart';

final movies = [
  Movie(
      id: 1,
      title: "The Shawshank Redemption",
      genre: "Drama",
      releaseYear: 1994,
      posterImage: "assets/images/movies/the_shawshank_redemption.jpg",
      showtimes: [
        "12:00 PM",
        "5:00 PM",
        "8:00 PM"
      ],
      seats: {
        0: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        1: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        2: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
      }),
  Movie(
      id: 2,
      title: "The Godfather",
      genre: "Crime, Drama",
      releaseYear: 1972,
      posterImage: "assets/images/movies/the_godfather.jpg",
      showtimes: [
        "2:00 PM",
        "6:00 PM",
        "9:00 PM"
      ],
      seats: {
        0: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        1: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        2: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
      }),
  Movie(
      id: 3,
      title: "The Dark Knight",
      genre: "Action, Crime, Thriller",
      releaseYear: 2008,
      posterImage: "assets/images/movies/the_dark_knight.jpg",
      showtimes: [
        "1:00 PM",
        "4:00 PM",
        "7:00 PM"
      ],
      seats: {
        0: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        1: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        2: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
      }),
  Movie(
      id: 4,
      title: "Pulp Fiction",
      genre: "Crime, Comedy, Mystery",
      releaseYear: 1994,
      posterImage: "assets/images/movies/pulp_fiction.jpg",
      showtimes: [
        "3:00 PM",
        "6:30 PM",
        "9:30 PM"
      ],
      seats: {
        0: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        1: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        2: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
      }),
  Movie(
      id: 5,
      title: "12 Angry Men",
      genre: "Drama, Legal",
      releaseYear: 1957,
      posterImage: "assets/images/movies/12_angry_men.jpg",
      showtimes: [
        "4:30 PM",
        "7:30 PM",
        "10:30 PM"
      ],
      seats: {
        0: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        1: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
        2: Seats(
          rows: 5,
          columns: 4,
          allSeats: List.generate(
              20,
              (index) =>
                  Seat(row: index ~/ 4, column: index % 4, isAvailable: true)),
        ),
      }),
];

void markSeatBooked(Movie movie, int timeSlotId, Seat seat) {
  final seats = movie.seats[timeSlotId];
  if (seats == null) {
    throw ArgumentError('Invalid time slot ID');
  }
  seats.getSeatAt(seat.row, seat.column).isAvailable = false;
}

Seats fetchSeatData(Movie movie, int timeSlotId) {
  final seats = movie.seats[timeSlotId];
  if (seats == null) {
    throw ArgumentError('Invalid time slot ID');
  }
  return seats;
}

final List<BookedSeats> bookedSeatsList = [];