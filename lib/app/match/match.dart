import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_list.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        // Leading back arrow button
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back navigation
              Navigator.of(context).pop();
            },
          ),
        ),
        // Title in the center
        title: const Text('Find your match'),
        centerTitle: true,
        // Action buttons on the right
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.event),
              onPressed: () {
                // Handle back navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventsPage()),
                );
              },
            ),
          ),
        ],
      ),
      // Main content area
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
            ), // Extra bottom padding for overlay
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Handle Filters action
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.black54,
                          size: 20,
                        ),
                        label: const Text(
                          'Filters',
                          style: TextStyle(color: Colors.black54),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Spacing
                      // Undo Button
                      TextButton.icon(
                        onPressed: () {
                          // Handle Undo action
                        },
                        icon: const Icon(
                          CupertinoIcons
                              .arrow_uturn_left, // Using Cupertino icon
                          color: Colors.white,
                          size: 16,
                        ),
                        label: const Text(
                          'Undo',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFCDB4DB,
                          ), // Light purple
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildProfileImage(context, 0.35),
                ),

                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildNameSection(),
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildCommonInterestBanner(),
                SizedBox(height: screenHeight * 0.03),
                _buildTagsRow(),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildLovesSection(),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildInfoSection(),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildProfileImage(context, 0.25),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildProfileImage(context, 0.25),
                ),
                SizedBox(height: screenHeight * 0.15),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16),
              child: Center(child: _buildActionButtons()),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the profile image
  Widget _buildProfileImage(BuildContext context, double imageHeight) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Image container with rounded corners
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            'https://storage.googleapis.com/gemini-chatbot-api-images/43b8456a-f75f-4695-885a-679a065644ae.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: screenHeight * imageHeight,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: screenHeight * imageHeight,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 400,
                color: Colors.grey[300],
                child: Center(
                  child: CircularProgressIndicator(
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                  ),
                ),
              );
            },
          ),
        ),

        // Heart icon positioned outside the bottom-right corner
        Positioned(
          bottom: -20,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Color(0xFFE0BBE4), // Soft purple
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for the name and verification badge
  Widget _buildNameSection() {
    return Row(
      children: [
        const Text(
          'Rhea Shah', // TODO: Replace with dynamic data
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        // Verification Badge
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.blue, // Standard verification color
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        ),
      ],
    );
  }

  // Helper widget for the common interest banner
  Widget _buildCommonInterestBanner() {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: Colors.black12)),

        const Icon(Icons.favorite, color: Color(0xFFFFB4A2), size: 16),
        const Expanded(child: Divider(thickness: 1, color: Colors.black12)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(
              0xFFF3D5B5,
            ), // Close to the beige tone in the screenshot
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(text: 'You both like '),
                TextSpan(
                  text: 'Mamma Mia',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF5A189A), // Muted purple
                  ),
                ),
              ],
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1, color: Colors.black12)),
        const Icon(Icons.favorite, color: Color(0xFFFFB4A2), size: 16),
        const Expanded(child: Divider(thickness: 1, color: Colors.black12)),
      ],
    );
  }

  // Helper widget for the row of tags/chips
  Widget _buildTagsRow() {
    // TODO: Replace with dynamic data
    return SingleChildScrollView(
      // Allow horizontal scrolling if needed
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 16),

          _InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          _InfoChip(label: 'Virgo'),
          SizedBox(width: 16),
          _InfoChip(label: 'Female'),
          SizedBox(width: 16),

          _InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          _InfoChip(label: 'Virgo'),
          SizedBox(width: 16),
          _InfoChip(label: 'Female'),
          SizedBox(width: 16),

          _InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          _InfoChip(label: 'Virgo'),
          SizedBox(width: 16),

          // Add more chips if necessary
        ],
      ),
    );
  }

  // Helper widget for the "Loves" section
  Widget _buildLovesSection() {
    // TODO: Replace with dynamic data
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity, // Makes it expand to the max width allowed

      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rhea loves', // TODO: Replace name dynamically
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            'Late night tacos',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Helper widget for the detailed info section
  Widget _buildInfoSection() {
    // TODO: Replace with dynamic data
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity, // Makes it expand to the max width allowed

      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _InfoRow(icon: Icons.location_on_outlined, text: '6.2 km away'),
          const SizedBox(height: 10),
          _InfoRow(icon: Icons.work_outline, text: 'Work'),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.cake_outlined,
            text: '26th August, 2000 - 24 years',
          ),
        ],
      ),
    );
  }

  // Helper widget for the bottom action buttons
  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Colors.orangeAccent,
        // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute buttons
        children: [
          _ActionButton(
            icon: Icons.close,
            circleColor: const Color.fromARGB(255, 120, 246, 255),
            color: Colors.purple,
            size: 20,
            onPressed: () {
              /* Handle reject action */
            },
          ),
          SizedBox(width: 20),
          _ActionButton(
            icon: Icons.favorite,
            circleColor: Colors.transparent,
            color: Colors.purple,
            size: 40, // Make heart slightly larger
            onPressed: () {
              /* Handle like action */
            },
          ),
          SizedBox(width: 20),
          _ActionButton(
            icon: Icons.check,
            circleColor: const Color.fromARGB(255, 120, 246, 255),
            color: Colors.purple,
            onPressed: () {
              /* Handle super like or match action */
            },
          ),
        ],
      ),
    );
  }
}

// --- Reusable Helper Widgets ---

// Custom Chip widget for profile tags
class _InfoChip extends StatelessWidget {
  final String label;
  final IconData? icon; // Optional icon

  const _InfoChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            // Conditionally add icon
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

// Custom widget for rows in the info section
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }
}

// Custom widget for the bottom action buttons (X, Heart, Check)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color circleColor;
  final VoidCallback onPressed;
  final double size; // Optional size parameter

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.circleColor,
    required this.onPressed,
    this.size = 20.0, // Default icon size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor, // White background for the circle
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        iconSize: size,
        padding: const EdgeInsets.all(10), // Padding inside the circle
        constraints: const BoxConstraints(), // Remove default constraints
        onPressed: onPressed,
        splashRadius: 30, // Control the splash effect radius
      ),
    );
  }
}
