// event_detail_page.dart
// (Place this class in its own file named event_detail_page.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation.

import 'package:flutter/material.dart';
import 'package:pineapple/app/chat/chat_home.dart';
import 'package:pineapple/app/match/match.dart';

// Example Event Data Model (replace with your actual model)
class EventDetails {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String signUpCount; // e.g., "1.2k"
  final String dateTime; // e.g., "Saturday, November 9, 7 PM"
  final String description;

  EventDetails({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.signUpCount,
    required this.dateTime,
    required this.description,
  });
}

class EventDetailPage extends StatefulWidget {
  // Define a static route name for easy access
  static const String routeName = '/event_detail';
  final EventDetails event;

  // Example event data (replace with actual data fetching/passing)
  static final EventDetails _exampleEvent = EventDetails(
    id: '123',
    title: 'Love Lounge',
    imageUrl:
        'https://placehold.co/600x400/E1BEE7/4A0072?text=Event+Image', // Placeholder
    location: 'Bastian - At The Top, Mumbai',
    signUpCount: '1.2k',
    dateTime: 'Saturday, November 9, 7 PM',
    description:
        'Lorem ipsum dolor sit amet consectetur. Volutpat diam neque eu dolor libero dignissim tempus id. Eget mi imperdiet tempor molestie mauris consequat faucibus faucibus. Integer ac fermentum consectetur metus phasellus sit sit convallis lacus. Ipsum aliquet ornare convallis erat venenatis egestas.',
  );

  // Constructor - requires event details
  EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  String? _selectedGender;

  // List of gender options
  final List<String> _genderOptions = [
    'Just a friend :)',
    'Casual Date ;)',
    'Looking For A Relationship',
  ];

  // Helper method to build icon + text rows
  Widget _buildDetailRow(IconData icon, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 18),
          const SizedBox(width: 10),
          Expanded(
            // Allow text to wrap if needed
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _showSwipeConfirmationDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.lightBlueAccent.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('What Are You Looking For?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._genderOptions.map((gender) {
                    bool isSelected = _selectedGender == gender;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            _selectedGender = gender;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.white
                                    : theme.scaffoldBackgroundColor,
                            border: Border.all(
                              color:
                                  isSelected
                                      ? theme.primaryColor
                                      : Colors.grey.shade400,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            gender,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  isSelected
                                      ? theme.primaryColor
                                      : Colors.black87,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedGender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select an option'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        Navigator.of(dialogContext).pop(); // Close first dialog
                        _showShareVibeDialog(context); // Show second dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showShareVibeDialog(BuildContext context) {
    final theme = Theme.of(context);

    // Local state for input fields
    String vibeAnswer1 = '';
    String vibeAnswer2 = '';
    String vibeAnswer3 = '';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Share your vibe', textAlign: TextAlign.center),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What are you passionate about?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (value) {
                        setDialogState(() => vibeAnswer1 = value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Type your answer...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "What's something fun about you?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (value) {
                        setDialogState(() => vibeAnswer2 = value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Type your answer...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "What’s your ideal vibe for the event?",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      onChanged: (value) {
                        setDialogState(() => vibeAnswer3 = value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Type your answer...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // You could send the data to a server here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchPage(),
                            ),
                          );
                          // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text("Continue"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // Use CustomScrollView for potential SliverAppBar effects if needed later
      body: CustomScrollView(
        slivers: <Widget>[
          // --- AppBar ---
          SliverAppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 1, // Slight elevation for separation
            pinned: true, // Keep AppBar visible when scrolling
            leading: IconButton(
              // Back button
              icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              // Event title in AppBar
              widget.event.title,
              style: TextStyle(
                color: Color(0xFF4A0072), // Dark purple
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true, // Center title
            // Optional actions like share or favorite
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.share_outlined, color: Colors.grey[800]),
            //     onPressed: () { /* TODO: Implement share */ },
            //   ),
            // ],
            actions: [
              IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: theme.primaryColor,
                ),
                onPressed: () {
                  // TODO: Implement bookmark functionality
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatHomePage()),
                  );
                },
              ),
            ],
          ),

          // --- Main Content Area ---
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity, // Force full horizontal stretch

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  // --- Event Image ---
                  Image.network(
                    widget.event.imageUrl,
                    width: double.infinity, // Stretch image to full width
                    height:
                        screenWidth *
                        0.6, // Adjust height as needed (e.g., 60% of width)
                    fit: BoxFit.cover, // Cover the area
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: screenWidth * 0.6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),

                  // --- Details Section below image ---
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title and Share Icon Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.event.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[850],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.ios_share_outlined,
                                color: theme.primaryColor,
                              ),
                              padding:
                                  EdgeInsets.zero, // Remove default padding
                              constraints:
                                  BoxConstraints(), // Remove default constraints
                              onPressed: () {
                                // TODO: Implement share functionality
                                print('Share button pressed');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Location, Sign-up count, Date/Time details
                        _buildDetailRow(
                          Icons.location_on_outlined,
                          widget.event.location,
                          context,
                        ),
                        _buildDetailRow(
                          Icons.group_outlined,
                          '${widget.event.signUpCount} have signed up!',
                          context,
                        ),
                        _buildDetailRow(
                          Icons.calendar_today_outlined,
                          widget.event.dateTime,
                          context,
                        ),
                        const SizedBox(height: 20),

                        // Event Description
                        Text(
                          widget.event.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5, // Line spacing
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Confirmation Text
                        Text(
                          "You're all set! Can't wait to see you there!!", // Example text
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Colors
                                    .green
                                    .shade700, // Green color for confirmation
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Swipe Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: Implement swipe action or navigation
                              _showSwipeConfirmationDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors
                                      .deepOrangeAccent, // Button color from screenshot
                              foregroundColor: Colors.white, // Text color
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Swipe now'),
                          ),
                        ),
                        const SizedBox(height: 30), // Bottom padding
                      ],
                    ),
                  ), // End Padding for details
                ],
              ),
            ),
          ), // End SliverToBoxAdapter
        ],
      ),
      // TODO: Add the actual BottomNavigationBar here if this is part of the main app flow
      // bottomNavigationBar: BottomNavigationBar(...),
    );
  }
}
