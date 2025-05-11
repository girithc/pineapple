import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_list.dart';
import 'package:pineapple/app/profile/profile_edit.dart';
import 'package:pineapple/app/profile/profile_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedBottomNavIndex = 4; // Index 4 for Profile in bottom nav

  // Placeholder profile data
  final String profileImageUrl =
      'https://placehold.co/200x200/E0E0E0/grey?text=Profile'; // Placeholder
  final String name = 'Rehaan Kapadia';
  final bool isVerified = false; // Example state

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
      // Handle navigation or state change based on bottom nav index
      // Example: if (index == 0) Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor, // Match background
        elevation: 0, // No shadow
        centerTitle: true,
        title: const Text(
          'Pineapple', // App Title
          style: TextStyle(
            // Consider adding a specific font here if 'Pineapple' has one
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black54,
            ), // Settings icon
            tooltip: 'Settings', // Accessibility
            onPressed: () {
              /* Handle settings icon press */
            },
          ),
          const SizedBox(width: 8), // Padding on the right
        ],
      ),
      body: SingleChildScrollView(
        // Allow scrolling if content overflows
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl),
              onBackgroundImageError: (_, __) {
                /* Handle error */
              },
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Verification Status
            Text(
              isVerified ? 'Verified' : "You're not verified yet",
              style: TextStyle(
                fontSize: 14,
                color: isVerified ? Colors.green : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),

            // Edit / View Buttons Container
            _buildEditViewButtons(),
            const SizedBox(height: 20),

            // Event History Button
            _buildOptionButton(
              icon: Icons.history_outlined,
              text: 'Event history',
              color: Colors.white, // Light cyan/blue
              onTap: () {
                /* Handle Event History tap */
              },
              borderColor: Colors.grey.shade300, // Add border for white button
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              icon: Icons.upcoming_outlined,
              text: 'Upcoming Events',
              color: Colors.white, // Light cyan/blue
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsPage()),
                );
              },
              borderColor: Colors.grey.shade300, // Add border for white button
            ),
            const SizedBox(height: 16),

            // Get Verified Card (only show if not verified)
            if (!isVerified) ...[
              _buildVerificationCard(),
              const SizedBox(height: 16),
            ],

            // Help Centre Button
            _buildOptionButton(
              icon: CupertinoIcons.phone, // Phone icon
              text: 'Help Centre',
              color: Colors.white, // White background
              onTap: () {
                /* Handle Help Centre tap */
              },
              borderColor: Colors.grey.shade300, // Add border for white button
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }

  // Helper widget for the Edit/View buttons row
  Widget _buildEditViewButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()),
              );
            },
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 24, // Adjust height as needed
            child: VerticalDivider(color: Colors.black, thickness: 1),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileViewPage()),
              );
            },
            child: const Text(
              'View',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for reusable option buttons (Event History, Help Centre)
  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
    Color? borderColor, // Optional border color
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          boxShadow: [
            // Subtle shadow for white buttons too
            if (borderColor != null)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  // Helper widget for the "Get Verified" card
  Widget _buildVerificationCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon and Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // Circle background for checkmark
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF6A1B9A),
                    width: 1.5,
                  ), // Purple border
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF6A1B9A),
                  size: 16,
                ), // Purple check
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Get verified',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),

          // Description Text
          Text(
            'Please verify your identity by taking a quick selfie to match your photos.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Verify Now Button
          ElevatedButton(
            onPressed: () {
              /* Handle Verify Now tap */
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A1B9A), // Purple color
              foregroundColor: Colors.white, // White text
              minimumSize: const Size(double.infinity, 45), // Full width
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Verify now',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
