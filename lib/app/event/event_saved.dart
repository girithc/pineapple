// The main EventsPage widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/event/event_list.dart';
import 'package:pineapple/app/event/event_register.dart' as register;
import 'package:pineapple/app/event/event_swipe.dart' as swipe;

class EventsSavePage extends StatefulWidget {
  const EventsSavePage({super.key});

  @override
  State<EventsSavePage> createState() => _EventsSavePage();
}

class _EventsSavePage extends State<EventsSavePage> {
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
        title: const Text('Saved Events'),
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
            ],
          ),

          SizedBox(height: screenHeight * 0.02),

          // List of Event Cards
          ...eventsData.map(
            (eventData) => Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ), // Spacing between cards
              child: GestureDetector(
                onTap: () {
                  // Navigate to the EventDetailPage, passing the placeholder event data
                  final swipe.EventDetails
                  placeholderEvent = swipe.EventDetails(
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
                          (context) => swipe.EventDetailPage(
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
                  isSaved: true,
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
}

// --- Reusable Event Card Widget ---
