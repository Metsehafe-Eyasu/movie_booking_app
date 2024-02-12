class Seats {
  final int rows;
  final int columns;
  final List<Seat> allSeats;

  Seats({
    required this.rows,
    required this.columns,
    required this.allSeats,
  });


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
  final int row;
  final int column;
  bool isAvailable;

  Seat({
    required this.row,
    required this.column,
    required this.isAvailable,
  });

  void updateAvailability(bool isAvailable) {
    this.isAvailable = isAvailable;
  }
}
