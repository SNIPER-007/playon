import 'package:flutter/material.dart';
import '../screens/ground_detail_screen.dart';

class GroundCard extends StatelessWidget {
  final String type; // cricket / football

  const GroundCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GroundDetailScreen(groundType: type),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                type == "cricket"
                    ? Icons.sports_cricket
                    : Icons.sports_soccer,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(height: 10),

              Text(
                type == "cricket"
                    ? "Cricket Ground"
                    : "Football Ground",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              Text(
                type == "cricket"
                    ? "₹5000 / slot"
                    : "₹2000 / 2 hrs",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}