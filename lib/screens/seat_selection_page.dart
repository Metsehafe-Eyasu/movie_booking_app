import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movie.dart';
import '../models/seats.dart';

class SeatSelectionPage extends StatefulWidget {
  final Seats seats;
  final Movie movie;

  const SeatSelectionPage({super.key, required this.seats, required this.movie});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<Seat> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    final totalSeats = widget.seats.allSeats.length;
    final availableSeats = widget.seats.getAvailableSeats();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: totalSeats,
                itemBuilder: (context, index) {
                  final seat = availableSeats[index];
                  return _buildSeatWidget(seat);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Selected Seats: ${selectedSeats.length}'),
                const Text('Total Price: \$TBD')
              ],
            ),
            ElevatedButton(
              onPressed: selectedSeats.isNotEmpty
                  ? () => _proceedToNextStep()
                  : null,
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatWidget(Seat seat) {
    final isAvailable = seat.isAvailable;
    final isSelected = selectedSeats.contains(seat);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? Colors.yellow
              : isAvailable
                  ? Colors.red
                  : Colors.grey,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () => _handleSeatSelection(seat),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              '${seat.row}-${seat.column}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isAvailable ? Colors.black : Colors.grey[500],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleSeatSelection(Seat seat) {
    setState(() {
      if (seat.isAvailable) {
        if (selectedSeats.contains(seat)) {
          selectedSeats.remove(seat);
        } else {
          selectedSeats.add(seat);
        }
      }
    });
  }

  _proceedToNextStep() {
    
    // Navigator.pushNamed(context, '/booking_confirmation', arguments: {
    //   'seats': selectedSeats,
    //   'movie': widget.movie,
    // });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: Text(
          'Are you sure you want to proceed with booking ${selectedSeats.length} seats for "${widget.movie.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel, closes dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Dismiss dialog
              Navigator.pushNamed(context, '/booking_confirmation', arguments: {
                'seats': selectedSeats,
                'movie': widget.movie,
              });
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }
}
