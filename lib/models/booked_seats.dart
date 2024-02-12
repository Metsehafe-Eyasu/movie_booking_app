import './movie.dart';
import './seats.dart';

class BookedSeats {
  final Movie movie;
  final int timeSlotId;
  final List<Seat> seats;
  final int confirmationNumber;

  BookedSeats({required this.movie, required this.timeSlotId, required this.seats, required this.confirmationNumber});
}
