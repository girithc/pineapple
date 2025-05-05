import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_list.dart';
import 'package:pineapple/app/match/match.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        // Assuming a back button would navigate here, so no explicit back button
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: IconButton(
            // Add a back button for navigation
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed:
                () => Navigator.of(context).pop(), // Standard back action
          ),
        ),
        title: Text('View Profile'), // Show first name in AppBar
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: TextButton(
              onPressed: () {
                // Handle Done action - save changes, navigate back etc.
                Navigator.of(context).pop(); // Example: just navigate back
              },
              child: const Text('Done'),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
            ), // Extra bottom padding for overlay
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: screenHeight * 0.04),
                _buildTagsRow(),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildLovesSection(),
                ),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildInfoSection(),
                ),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildProfileImage(context, 0.25),
                ),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: _buildProfileImage(context, 0.25),
                ),
                SizedBox(height: screenHeight * 0.15),
              ],
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
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    0.2,
                  ), // Shadow color with opacity
                  offset: Offset(0, 4), // Horizontal and vertical offset
                  blurRadius: 10, // Softness of the shadow
                  spreadRadius: 2, // Size of the shadow
                ),
              ],
            ),

            child: Icon(
              Icons.favorite,
              color: Colors.pink.shade300, // Soft purple
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
          'Rehaan', // TODO: Replace with dynamic data
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

          InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          InfoChip(label: 'Virgo'),
          SizedBox(width: 16),
          InfoChip(label: 'Female'),
          SizedBox(width: 16),

          InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          InfoChip(label: 'Virgo'),
          SizedBox(width: 16),
          InfoChip(label: 'Female'),
          SizedBox(width: 16),

          InfoChip(label: 'Height: 5\'6"'),
          SizedBox(width: 16),
          InfoChip(label: 'Virgo'),
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
          InfoRow(icon: Icons.location_on_outlined, text: '6.2 km away'),
          const SizedBox(height: 10),
          InfoRow(icon: Icons.work_outline, text: 'Work'),
          const SizedBox(height: 10),
          InfoRow(
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
          ActionButton(
            icon: Icons.close,
            circleColor: const Color.fromARGB(255, 120, 246, 255),
            color: Colors.purple,
            size: 20,
            onPressed: () {
              /* Handle reject action */
            },
          ),
          SizedBox(width: 20),
          ActionButton(
            icon: Icons.favorite,
            circleColor: Colors.transparent,
            color: Colors.purple,
            size: 40, // Make heart slightly larger
            onPressed: () {
              /* Handle like action */
            },
          ),
          SizedBox(width: 20),
          ActionButton(
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
