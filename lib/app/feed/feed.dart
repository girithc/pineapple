// feed_page.dart
// (Place this class in its own file named feed_page.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation (likely the home screen).

import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_swipe.dart';
import 'package:pineapple/app/profile/profile_home.dart';

class FeedPage extends StatefulWidget {
  // Define a static route name if needed for direct navigation,
  // but this is often the initial route after login.
  static const String routeName = '/feed';

  // Assume user's name is passed or retrieved after login
  final String userName;

  const FeedPage({
    super.key,
    this.userName = "Rehaan",
  }); // Default name for example

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // Use the scaffold background color from the theme
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        // Use SingleChildScrollView to allow the whole page to scroll
        child: SingleChildScrollView(
          child: Padding(
            // Consistent horizontal padding
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),

                // --- Top Section: Greeting, Location, Search ---
                _buildTopSection(context, widget.userName),
                const SizedBox(height: 25),

                // --- Registered Events Section ---
                _buildSectionTitle('Registered Events'),
                const SizedBox(height: 15),
                _buildRegisteredEventCard(context), // Placeholder card
                const SizedBox(height: 30),

                // --- Upcoming Events Section ---
                _buildSectionTitle('Meet & Mingle: Upcoming Events'),
                const SizedBox(height: 15),
                _buildHorizontalEventList(
                  context,
                  _buildUpcomingEventCard,
                ), // Horizontal list
                const SizedBox(height: 30),

                // --- Recommended Events Section ---
                /*
                _buildSectionTitle("Events You'll Love!"),
                const SizedBox(height: 15),
                _buildHorizontalEventList(
                  context,
                  _buildRecommendedEventCard,
                ), // Horizontal list
                */
                const SizedBox(height: 30), // Padding at the bottom
              ],
            ),
          ),
        ),
      ),
      // TODO: Add Bottom Navigation Bar if needed for the app structure
      // bottomNavigationBar: BottomNavigationBar(...),
    );
  }

  // --- Helper Widget: Top Section ---
  Widget _buildTopSection(BuildContext context, String userName) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello $userName',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A0072), // Dark purple
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: Icon(Icons.person),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Location Text
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.grey[700], size: 18),
            const SizedBox(width: 4),
            Text(
              'Mumbai', // Hardcoded location for example
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.white, // White background
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14.0,
            ), // Adjust padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), // More rounded corners
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ), // Lighter border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 1.5,
              ), // Theme color on focus
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widget: Section Title ---
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[850],
      ),
    );
  }

  // --- Helper Widget: Registered Event Card ---
  Widget _buildRegisteredEventCard(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    // Use fixed height or aspect ratio based on design needs
    final cardHeight = screenWidth * 0.55; // Example height calculation

    return Card(
      color: Colors.white,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      shadowColor: Colors.white,
      elevation: 4.0, // Subtle shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      clipBehavior: Clip.antiAlias, // Clip the child content (image)
      child: GestureDetector(
        onTap: () {
          // Create an instance of EventDetails with placeholder data
          final EventDetails placeholderEvent = EventDetails(
            id: 'placeholder_id_123', // Unique ID for the event
            title: 'Placeholder Event Title', // Name of the event
            imageUrl:
                'https://placehold.co/600x400/CCCCCC/777777?text=Event+Image', // Placeholder image URL
            location:
                'Placeholder Location, City', // Where the event takes place
            signUpCount: '100+', // Example sign-up count
            dateTime: 'Sunday, May 4, 8:00 PM', // Example date and time
            description:
                'This is a placeholder description for the event. More details would go here, explaining what the event is about and what attendees can expect.', // Example description
          );

          // Navigate to the EventDetailPage, passing the placeholder event data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => EventDetailPage(
                    event:
                        placeholderEvent, // Pass the created EventDetails object
                  ),
            ),
          );
        },
        child: Container(
          // decoration: BoxDecoration( // Optional gradient overlay
          //   gradient: LinearGradient(...)
          // ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Placeholder
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      // Replace with your image source
                      'https://placehold.co/100x100/E1BEE7/4A0072?text=Event', // Placeholder
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 80,
                            width: 80,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey.shade400,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Event Details Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sign-up count badge (optional)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '1.2k signed up', // Example data
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Love Lounge', // Example data
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[850],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bastion - At The Top, Mumbai', // Example data
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Leave the small talk behind! This event is all about genuine conversations, playful moments, and meeting people who just get it.', // Example data
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            height: 1.3,
                          ),
                          maxLines: 3, // Limit description lines
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Swipe Indicator / Button
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    /* TODO: Handle swipe action */
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent.shade200,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Swipe here',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget: Horizontal Event List ---
  Widget _buildHorizontalEventList(
    BuildContext context,
    Widget Function(BuildContext, int) cardBuilder,
  ) {
    // Adjust height based on the card type

    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.3, // Set a fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make it scroll horizontally
        itemCount: 5, // Example: Number of items in the list
        itemBuilder: (context, index) {
          return Padding(
            // Add spacing between cards
            padding: EdgeInsets.only(
              right: 15.0,
              bottom: 5.0,
              top: 5.0,
            ), // Add padding for shadow visibility
            child: cardBuilder(context, index), // Build the specific card type
          );
        },
      ),
    );
  }

  // --- Helper Widget: Upcoming Event Card ---
  Widget _buildUpcomingEventCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Calculate card width (e.g., 60% of screen width)
    final cardWidth = screenWidth * 0.65;

    return Card(
      color: theme.primaryColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay text
            Stack(
              children: [
                Image.network(
                  // Replace with your image source
                  'https://placehold.co/300x150/81D4FA/01579B?text=Event+${index + 1}', // Placeholder
                  height: screenHeight * 0.1, // Fixed image height
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade400,
                        ),
                      ),
                ),
                // Sign-up count overlay
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${index + 1}k signed up', // Example data
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Event details below image
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Register Now', // Example data
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget: Recommended Event Card ---
  Widget _buildRecommendedEventCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    // Smaller card width
    final cardWidth = screenWidth * 0.45;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay text
            Stack(
              children: [
                Image.network(
                  // Replace with your image source
                  'https://placehold.co/200x100/FFCCBC/BF360C?text=Rec+${index + 1}', // Placeholder
                  height: 100, // Fixed image height
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey.shade400,
                        ),
                      ),
                ),
                // Sign-up count overlay
                Positioned(
                  bottom: 8, // Position at bottom
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${800 + index * 50} signed up', // Example data
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // Optional: Add minimal text below if needed
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Event Title ${index+1}', style: TextStyle(fontSize: 12)),
            // ),
          ],
        ),
      ),
    );
  }
}

// --- How to Navigate (Reminder) ---
// This page is likely the home page, set in main.dart's initialRoute or home property.
// Example if navigating from login:
/*
Navigator.pushReplacementNamed(
  context,
  FeedPage.routeName,
  arguments: 'Rehaan' // Pass user name if needed
);
*/

// --- How to Add Route in main.dart (Reminder) ---
// In your main.dart's MaterialApp routes:
/*
MaterialApp(
  // ... other properties ...
  initialRoute: FeedPage.routeName, // Make it the starting page after login setup
  routes: {
    // ... other routes
    FeedPage.routeName: (context) {
      // Example of handling potential arguments (like user name)
      final args = ModalRoute.of(context)?.settings.arguments;
      final userName = args is String ? args : "User"; // Default if no name passed
      return FeedPage(userName: userName);
    },
    // ...
  },
)
*/
