import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../models/movie.dart';
import '../models/seats.dart';

class BookingConfirmationPage extends StatelessWidget {
  final List<Seat> selectedSeats;
  final Movie movie;

  const BookingConfirmationPage({
    super.key,
    required this.selectedSeats,
    required this.movie,
  });

  Future<void> updateJson(List<Seat> selectedSeats) async {
    // Load seats JSON data
    final jsonData = await rootBundle.loadString('assets/data/seats.json');
    final data = jsonDecode(jsonData) as Map<String, dynamic>;
    final movies = data['movies'] as List<dynamic>;

    // Find the matching movie data and update its "seats"
    final movieData = movies.firstWhere((data) => data['movie_id'] == movie.id);
    final seats = Seats.fromJson(movieData);

    // Update booked seats in the allSeats list
    for (final seat in selectedSeats) {
      seats.allSeats[seat.row * seats.columns + seat.column]
          .updateAvailability(false);
    }
    seats.printSeats();
    // Update the matching movie data with the modified seats
    movieData['seats'] = seats.allSeats.map((seat) => seat.toJson()).toList();
  
    // Update and save the entire JSON data
    final updatedData = jsonEncode(data);

    // Write the updated JSON to the file
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final seatsFile = File('${appDocumentsDirectory.path}/seats.json');

    try {
      await seatsFile.writeAsString(updatedData);
    } catch (error) {
      // Handle error gracefully, e.g., show a user message
    }
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
              onPressed: () async {
                await updateJson(selectedSeats); // Update JSON asynchronously
                // ignore: use_build_context_synchronously
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
