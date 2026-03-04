import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroundDetailScreen extends StatefulWidget {
  final String groundType;

  const GroundDetailScreen({super.key, required this.groundType});

  @override
  State<GroundDetailScreen> createState() =>
      _GroundDetailScreenState();
}

class _GroundDetailScreenState extends State<GroundDetailScreen> {
Future<void> saveBooking() async {
  final bookingId =
      "PLY-${DateTime.now().millisecondsSinceEpoch}";

  await FirebaseFirestore.instance.collection('bookings').add({
    "booking_id": bookingId,
    "ground_type": widget.groundType,
    "slot": selectedSlot,
    "date": selectedDate!.toString(),
    "created_at": Timestamp.now(),
  });
}
  DateTime? selectedDate;
  String selectedSlot = "";

  // 🔥 DYNAMIC SLOT LOGIC
  List<String> getSlots() {
    if (widget.groundType == "cricket") {
      return [
        "6 AM - 10 AM (4 hrs)",
        "10 AM - 2 PM (4 hrs)",
        "2 PM - 6 PM (4 hrs)",
        "Full Day (8 hrs)",
      ];
    } else {
      return [
        "6 AM - 8 AM",
        "8 AM - 10 AM",
        "4 PM - 6 PM",
        "6 PM - 8 PM",
        "8 PM - 10 PM",
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final slots = getSlots();

    return Scaffold(
      backgroundColor: const Color(0xFF081626),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 📸 IMAGE
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1593341646782-e0b495cff86d",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 15,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // 🏟️ NAME + TYPE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.groundType == "cricket"
                        ? "Cricket Ground"
                        : "Football Ground",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.groundType == "cricket"
                        ? "₹5000"
                        : "₹2000",
                    style: const TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.groundType.toUpperCase(),
                style: const TextStyle(color: Colors.orange),
              ),
            ),

            const SizedBox(height: 20),

            // 📅 DATE PICKER
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Select Date",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );

                  if (picked != null) {
                    setState(() => selectedDate = picked);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedDate == null
                        ? "Choose Date"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    style:
                        const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ⏰ SLOT SECTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Select Slot",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                children: slots.map((slot) {
                  final isSelected = selectedSlot == slot;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedSlot = slot);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange
                            : Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        slot,
                        style: const TextStyle(
                            color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 CONFIRM BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () async {
  if (selectedDate == null || selectedSlot.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select date & slot")),
    );
    return;
  }

  await saveBooking();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Booking Saved Successfully")),
  );
},
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.red]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Confirm Booking",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}