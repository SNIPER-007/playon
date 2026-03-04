import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081626),
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No bookings yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {

              final booking = bookings[index];

              return Card(
                color: Colors.white10,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    "Booking ID: ${booking['booking_id']}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ground: ${booking['ground_type']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "Slot: ${booking['slot']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        "Date: ${booking['date']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}