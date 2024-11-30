import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 261,
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
          // Menggunakan Image.asset untuk gambar
          Container(
            width: 220,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              image: DecorationImage(
                image: AssetImage('lib/assets/images/event-1.jpg'), // Perbarui dengan Image.asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hackaton : UI/UX Management System Apps',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '30 Desember 2023',
                  style: TextStyle(
                    color: Color(0xFF89939E),
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'MARKAS | Surabaya',
                  style: TextStyle(
                    color: Color(0xFF89939E),
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFDA1E3D),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
