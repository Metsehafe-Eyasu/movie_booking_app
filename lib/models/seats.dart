class Seats {
  final int movieId;
  final int rows;
  final int columns;
  final List<List<int>> seatAvailability;
  final List<Seat> allSeats;

  Seats({
    required this.movieId,
    required this.rows,
    required this.columns,
    required this.seatAvailability,
    required this.allSeats,
  });

  factory Seats.fromJson(Map<String, dynamic> json) {
    final movieId = json['movie_id'] as int;
    final rows = json['rows'] as int;
    final columns = json['columns'] as int;
    final seatAvailability = List<List<int>>.from(
      (json['seats'] as List<dynamic>).map((row) => List<int>.from(row)),
    );

    final allSeats = List<Seat>.generate(
      rows * columns,
      (index) {
        final row = index ~/ columns;
        final col = index % columns;
        return Seat(
          movieId: movieId,
          row: row,
          column: col,
          isAvailable: seatAvailability[row][col] == 0 ? true : false,
        );
      },
    );

    return Seats(
      movieId: movieId,
      rows: rows,
      columns: columns,
      seatAvailability: seatAvailability,
      allSeats: allSeats,
    );
  }

  // Get a specific seat by its row and column
  Seat getSeatAt(int row, int column) {
    if (row < 0 || row >= rows || column < 0 || column >= columns) {
      throw ArgumentError('Invalid row or column index');
    }
    return allSeats[row * columns + column];
  }

  // Get all available seats (as Seat objects)
  List<Seat> getAvailableSeats() {
    return allSeats.where((seat) => seat.isAvailable).toList();
  }

  // Print all seat information (for debugging)
  void printSeats() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        final seat = getSeatAt(row, col);
        print(
            '(${seat.row}, ${seat.column}): ${seat.isAvailable ? 'Available' : 'Unavailable'}');
      }
    }
  }
}

class Seat {
  final int movieId;
  final int row;
  final int column;
  bool isAvailable;

  Seat({
    required this.movieId,
    required this.row,
    required this.column,
    required this.isAvailable,
  });

  void updateAvailability(bool isAvailable) {
    this.isAvailable = isAvailable;
  }

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'row': row,
      'column': column,
      'isAvailable': isAvailable,
    };
  }
}
