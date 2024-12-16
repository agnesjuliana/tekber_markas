import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventCard extends StatelessWidget {
  final QueryDocumentSnapshot eventData;

  const EventCard({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Event clicked: ${eventData['title']}");
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar banner
            Container(
              width: 220,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                image: DecorationImage(
                  image: NetworkImage(eventData['bannerUrl'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul event
                  Text(
                    eventData['title'] ?? 'Judul Event',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  // Tanggal event
                  Text(
                    eventData['date'] != null
                        ? '${eventData['date'].toDate()}'
                        : 'Tanggal Event',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF89939E),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Lokasi event
                  Text(
                    eventData['location'] ?? 'Lokasi Event',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF89939E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
