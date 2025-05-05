import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/chat/match_card.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  int _selectedSegment = 0; // 0 for Chat, 1 for Match
  int _selectedBottomNavIndex = 3; // Index 3 for Chat in bottom nav

  // Placeholder chat data - replace with actual data model and fetching
  final List<Map<String, dynamic>> chatData = [
    {
      'imageUrl':
          'https://placehold.co/100x100/E0E0E0/grey?text=Rhea', // Placeholder
      'name': 'Rhea Shah',
      'event': 'The Lil Flea',
      'lastMessage': 'Lorem ipsum dolor sit amet consectetur.',
      'time': '7:30',
      'unreadCount': 3,
    },
    {
      'imageUrl':
          'https://placehold.co/100x100/D0D0D0/grey?text=Sakshi', // Placeholder
      'name': 'Sakshi Kapoor',
      'event': 'Love Lounge',
      'lastMessage': 'Lorem ipsum dolor sit amet consectetur.',
      'time': '7:30',
      'unreadCount': 3,
    },
    {
      'imageUrl':
          'https://placehold.co/100x100/C0C0C0/grey?text=Riana', // Placeholder
      'name': 'Riana Mehta',
      'event': 'Love Lounge',
      'lastMessage': 'Lorem ipsum dolor sit amet consectetur.',
      'time': '7:30',
      'unreadCount': 3,
    },
    // Add more chat items
  ];

  final List<Map<String, dynamic>> matchData = [
    {
      'imageUrl':
          'https://placehold.co/300x400/DBC4F0/white?text=Match+1', // Placeholder
      'name': 'Rhea Shah',
      'event': 'The Lil Flea',
      'distance': '10 kms away',
    },
    {
      'imageUrl':
          'https://placehold.co/300x400/FFCACC/white?text=Match+2', // Placeholder
      'name': 'Sakshi Kapoor',
      'event': 'Love Lounge',
      'distance': '12 kms away',
    },
    {
      'imageUrl':
          'https://placehold.co/300x400/DBC4F0/white?text=Match+3', // Placeholder
      'name': 'Rhea Shah', // Example duplicate
      'event': 'The Lil Flea',
      'distance': '10 kms away',
    },
    {
      'imageUrl':
          'https://placehold.co/300x400/FFCACC/white?text=Match+4', // Placeholder
      'name': 'Sakshi Kapoor', // Example duplicate
      'event': 'Love Lounge',
      'distance': '12 kms away',
    },
    // Add more match items
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
      // Handle navigation or state change based on bottom nav index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No standard AppBar, using Column in body for custom header
      body: SafeArea(
        // Ensures content doesn't overlap status bar
        child: Column(
          children: [
            // Custom Header Section (Segmented Control + Search)
            _buildCustomHeader(context),

            // Chat List (or Match list based on segment)
            Expanded(
              child:
                  _selectedSegment == 0
                      ? _buildChatList() // Show chat list if segment is 0
                      : _buildMatchGrid(), // Show match list/content if segment is 1
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
    );
  }

  // Widget for the custom header section
  Widget _buildCustomHeader(BuildContext context) {
    final double horizontalPadding = 16.0;
    final double maxWidth =
        MediaQuery.of(context).size.width - (horizontalPadding * 2);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(horizontalPadding),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // Segmented Control
          SizedBox(
            width: maxWidth,
            child: CupertinoSegmentedControl<int>(
              children: const {
                0: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text('Chat'),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text('Match'),
                ),
              },
              onValueChanged: (int newValue) {
                setState(() {
                  _selectedSegment = newValue;
                });
              },
              groupValue: _selectedSegment,
              selectedColor: theme.primaryColor,
              unselectedColor: Colors.white,
              borderColor: theme.primaryColor,
              pressedColor: const Color(0xFFE0BBE4).withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 16),
          // Search Bar
          Container(
            width: maxWidth,
            child: CupertinoSearchTextField(
              placeholder: 'Search',
              backgroundColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.0),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              onChanged: (value) {
                // Handle search query changes
              },
              onSubmitted: (value) {
                // Handle search submission
              },
            ),
          ),
        ],
      ),
    );
  } // Widget for building the list of chat items

  Widget _buildChatList() {
    return ListView.builder(
      itemCount: chatData.length,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ), // Add horizontal padding
      itemBuilder: (context, index) {
        final chat = chatData[index];
        return ChatListItem(
          imageUrl: chat['imageUrl'],
          name: chat['name'],
          event: chat['event'],
          lastMessage: chat['lastMessage'],
          time: chat['time'],
          unreadCount: chat['unreadCount'],
          onTap: () {
            // Handle tapping on a chat item (navigate to chat screen)
            print('Tapped on ${chat['name']}');
          },
        );
      },
    );
  }

  // Placeholder widget for the "Match" section content
  Widget _buildMatchGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0), // Padding around the grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        crossAxisSpacing: 12.0, // Horizontal spacing between cards
        mainAxisSpacing: 12.0, // Vertical spacing between cards
        childAspectRatio:
            0.75, // Adjust aspect ratio (width / height) as needed
      ),
      itemCount: matchData.length,
      itemBuilder: (context, index) {
        final match = matchData[index];
        return MatchCard(
          imageUrl: match['imageUrl'],
          name: match['name'],
          event: match['event'],
          distance: match['distance'],
          onTap: () {
            // Handle tapping on a match card (e.g., view profile)
            print('Tapped on match: ${match['name']}');
          },
          onMessageTap: () {
            // Handle tapping the message icon
            print('Tapped message icon for: ${match['name']}');
          },
        );
      },
    );
  }
}

// --- Reusable Chat List Item Widget ---

class ChatListItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String event;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.event,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Makes the row tappable
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ), // Spacing between items
        child: Row(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                // Optionally handle image loading errors
                print("Error loading image: $exception");
              },
              backgroundColor: Colors.grey[300], // Fallback color
            ),
            const SizedBox(width: 16),
            // Name, Event, Message Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Event Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDAB9), // Light orange color
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          event,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD95500), // Darker orange text
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Time and Unread Count Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 6),
                // Unread Count Badge (only show if count > 0)
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC8E6C9), // Light green color
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Color(0xFF2E7D32), // Darker green text
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
