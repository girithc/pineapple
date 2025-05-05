import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_register.dart';

// The main EventsPage widget
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  int _selectedIndex = 1; // Index 1 corresponds to the Events tab

  // Placeholder data for events - replace with actual data fetching
  final List<Map<String, String>> eventsData = [
    {
      'image':
          'https://placehold.co/600x400/E0E0E0/grey?text=Outdoor+Cinema', // Placeholder
      'location': 'Mumbai',
      'name': 'Outdoor Cinema',
      'date': '11 Dec, Saturday',
    },
    {
      'image':
          'https://placehold.co/600x400/D0D0D0/grey?text=Zomaland+1', // Placeholder
      'location': 'Mumbai',
      'name': 'Zomaland',
      'date': '11 Dec, Saturday',
    },
    {
      'image':
          'https://placehold.co/600x400/C0C0C0/grey?text=Zomaland+2', // Placeholder
      'location': 'Mumbai',
      'name': 'Zomaland',
      'date': '11 Dec, Saturday',
    },
    // Add more events as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation based on index
      // e.g., if (index == 0) Navigator.push(...)
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            // Using leading for the left-most icon if needed, else remove
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            tooltip: 'Go Back', // Tooltip for accessibility
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              // Using leading for the left-most icon if needed, else remove
              icon: const Icon(
                Icons.bookmark_border_outlined,
                color: Colors.black54,
              ),
              tooltip: 'Saved', // Tooltip for accessibility
              onPressed: () {
                // Handle Saved action
              },
            ),
          ),
        ],
      ),
      body: ListView(
        // Use ListView for scrollable content
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
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
                  CupertinoIcons.arrow_uturn_left, // Using Cupertino icon
                  color: Colors.white,
                  size: 16,
                ),
                label: const Text(
                  'Undo',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFCDB4DB), // Light purple
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

          SizedBox(height: screenHeight * 0.02),

          // Create an event button
          _buildCreateEventButton(),
          SizedBox(height: screenHeight * 0.02),

          // List of Event Cards
          ...eventsData.map(
            (eventData) => Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ), // Spacing between cards
              child: GestureDetector(
                onTap: () {
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
                          (context) => EventRegisterPage(
                            event:
                                placeholderEvent, // Pass the created EventDetails object
                          ),
                    ),
                  );
                },
                child: EventCard(
                  imageUrl: eventData['image']!,
                  location: eventData['location']!,
                  name: eventData['name']!,
                  date: eventData['date']!,
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
    );
  }

  // Helper widget for the "Create an event" button
  Widget _buildCreateEventButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle Create event action
      },
      icon: const Icon(Icons.add, color: Colors.black87, size: 20),
      label: const Text(
        'Create an event',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB2EBF2), // Light cyan/blue color
        minimumSize: const Size(
          double.infinity,
          50,
        ), // Full width, fixed height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0, // No shadow for a flatter look
      ),
    );
  }
}

// --- Reusable Event Card Widget ---

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String name;
  final String date;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Ensures content respects border radius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4.0, // Add shadow to the card
      child: Stack(
        alignment:
            Alignment.center, // Center content both vertically and horizontally
        children: [
          // Background Image
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
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

          // Gradient overlay for text readability
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Centered Text Content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Bookmark Icon Button
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                iconSize: 24,
                tooltip: 'Save Event',
                onPressed: () {
                  // Handle bookmark
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
