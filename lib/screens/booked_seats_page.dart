import 'package:flutter/material.dart';
import '../utils/data.dart';

class BookedSeatsScreen extends StatefulWidget {
  const BookedSeatsScreen({Key? key}) : super(key: key);

  @override
  State<BookedSeatsScreen> createState() => _BookedSeatsScreenState();
}

class _BookedSeatsScreenState extends State<BookedSeatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Seats'),
      ),
      body: bookedSeatsList.isEmpty
          ? const Center(child: Text('No booked seats found yet!'))
          : ListView.builder(
              itemCount: bookedSeatsList.length,
              itemBuilder: (context, index) {
                final bookedSeat = bookedSeatsList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(bookedSeat.movie.title),
                            Text(
                              bookedSeat.movie.showtimes[bookedSeat.timeSlotId],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Text('Seats:'),
                            const SizedBox(width: 8.0),
                            Text(bookedSeat.seats
                                .map((seat) => '${seat.row}-${seat.column}')
                                .join(', '))
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Confirmation Number:'),
                            const SizedBox(width: 8.0),
                            Text('${bookedSeat.confirmationNumber}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
