import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDA1E3D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 0),
            blurRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 0),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            assetPath: 'lib/assets/icons/home.png', // Still passing string here
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavBarItem(
            assetPath: 'lib/assets/icons/event.png', // Still passing string here
            label: 'Event',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavBarItem(
            assetPath: 'lib/assets/icons/calendar.png', // Still passing string here
            label: 'Calendar',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavBarItem(
            assetPath: 'lib/assets/icons/profile.png', // Still passing string here
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String assetPath; // This is still a string holding the path to the image
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    Key? key,
    required this.assetPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            child: Image.asset(
              assetPath, // This is where we call Image.asset() with the path from assetPath
              color: Colors.white, // Apply a white tint if needed
              fit: BoxFit.contain,
            ),
          ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                ),
              ),
            )
          else
            const SizedBox(height: 8), // Spacer when not active
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Open Sans",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.16, // Line-height equivalent
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
