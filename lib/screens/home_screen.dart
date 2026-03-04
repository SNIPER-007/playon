import 'package:flutter/material.dart';
import '../widgets/ground_card.dart';
import 'my_bookings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081626),

      // 🔥 PREMIUM APP BAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B1F3A),
                  Color(0xFF112D5C),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // LEFT SIDE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Playon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Mumbai",
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),

                // RIGHT SIDE (MY BOOKINGS + NOTIFICATIONS)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.bookmark, color: Colors.white),
                      tooltip: "My Bookings",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MyBookingsScreen(),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.notifications,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // 🔥 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔍 SEARCH BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search grounds, matches, tournaments...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ⚡ QUICK ACTIONS
            Row(
              children: [
                Expanded(child: actionButton("Book Ground")),
                const SizedBox(width: 12),
                Expanded(child: actionButton("Create Match")),
              ],
            ),

            const SizedBox(height: 30),

            // 📍 NEARBY GROUNDS
            const Text(
              "Nearby Grounds",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  GroundCard(type: "cricket"),
                  GroundCard(type: "football"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔴 LIVE MATCHES
            const Text(
              "Live Matches",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            liveMatchCard(),

            const SizedBox(height: 30),

            // 🏆 TOURNAMENTS
            const Text(
              "Tournaments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            tournamentCard(),
          ],
        ),
      ),
    );
  }

  // 🔥 ACTION BUTTON
  static Widget actionButton(String text) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.red],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // 🔴 LIVE MATCH CARD
  static Widget liveMatchCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team A vs Team B",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            "120/3 (15.2 overs)",
            style: TextStyle(color: Colors.orange, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 🏆 TOURNAMENT CARD
  static Widget tournamentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sunday Premier League",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            "Starts 10 March",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}