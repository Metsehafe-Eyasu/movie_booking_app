import 'dart:math';

import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/seats.dart';
import '../models/booked_seats.dart';

import '../utils/data.dart';

class BookingConfirmationPage extends StatelessWidget {
  final List<Seat> selectedSeats;
  final Movie movie;
  final int timeSlotId;

  const BookingConfirmationPage({
    super.key,
    required this.selectedSeats,
    required this.movie,
    required this.timeSlotId,
  });

  Future<void> updateJson(List<Seat> selectedSeats, int confirmationNumber) async {
    for (final seat in selectedSeats) {
      markSeatBooked(movie, timeSlotId, seat);
    }
    bookedSeatsList.add(BookedSeats(movie: movie, timeSlotId: timeSlotId, seats: selectedSeats, confirmationNumber: confirmationNumber));
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = 10 * selectedSeats.length;
    final confirmationNumber = Random().nextInt(1000000) + 100000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    movie.posterImage,
                    width: 100.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Genre: ${movie.genre}'),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),

            const Text('Selected Seats:', style: TextStyle(fontSize: 18.0)),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final seat = selectedSeats[index];
                return Text('Row: ${seat.row}, Column: ${seat.column}');
              },
              itemCount: selectedSeats.length,
            ),

            // Total price and confirmation number
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 16.0)),
                Text('$totalPrice',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Confirmation Number:',
                    style: TextStyle(fontSize: 16.0)),
                Text('$confirmationNumber',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                updateJson(selectedSeats, confirmationNumber);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
