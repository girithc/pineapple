// interests_page.dart
// (Place this class in its own file named interests_page.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation.

import 'package:flutter/material.dart';
import 'package:pineapple/app/feed/feed.dart';

class InterestsPage extends StatefulWidget {
  // Define a static route name for easy access
  static const String routeName = '/interests_page';

  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  // State variable to store the selected interests. Using a Set for efficient add/remove.
  final Set<String> _selectedInterests = {};

  // List of available interests - add more as needed
  final List<String> _interestOptions = [
    'Photography',
    'Travel',
    'Reading',
    'Movies',
    'Music',
    'Gaming',
    'Cooking',
    'Sports',
    'Art',
    'Writing',
    'Hiking',
    'Dancing',
    'Technology',
    'Fashion',
    'Fitness',
    'Volunteering',
    'Yoga',
    'History',
    'Science',
    'Animals',
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and theme
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    // Determine if the button should be enabled (at least one interest selected)
    final bool isButtonEnabled = _selectedInterests.isNotEmpty;

    return Scaffold(
      // Optional AppBar if back navigation is needed
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Your Interests', // Page title
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          // Consistent horizontal padding
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            // Align content to the start (left)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20), // Add some space at the top
              // --- Prompt Text ---
              Text(
                'Select a few of your interests',
                style: TextStyle(
                  fontSize: 18, // Adjust size as needed
                  fontWeight: FontWeight.w500, // Medium weight
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 25), // Spacing
              // --- Interests Selection Grid ---
              // Use Expanded + SingleChildScrollView for scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10.0, // Horizontal spacing between chips
                    runSpacing: 10.0, // Vertical spacing between lines of chips
                    children:
                        _interestOptions.map((interest) {
                          bool isSelected = _selectedInterests.contains(
                            interest,
                          );
                          return FilterChip(
                            label: Text(interest),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _selectedInterests.add(interest);
                                } else {
                                  _selectedInterests.remove(interest);
                                }
                              });
                            },
                            // --- Styling for FilterChip ---
                            backgroundColor:
                                Colors
                                    .grey
                                    .shade200, // Background for unselected
                            selectedColor: theme.primaryColor.withOpacity(
                              0.15,
                            ), // Background for selected
                            labelStyle: TextStyle(
                              color:
                                  isSelected
                                      ? theme.primaryColor
                                      : Colors.black87,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ), // Rounded shape
                              side: BorderSide(
                                color:
                                    isSelected
                                        ? theme.primaryColor
                                        : Colors.grey.shade400,
                                width: isSelected ? 1.0 : 1.0,
                              ),
                            ),
                            showCheckmark:
                                false, // Don't show checkmark, selection indicated by style
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ), // End of Expanded for scrollable Wrap

              const SizedBox(height: 20), // Spacing before button
              // --- Continue Button ---
              SizedBox(
                width: double.infinity, // Make button stretch
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isButtonEnabled
                            ? const Color(0xFF6200EE)
                            : Colors
                                .grey
                                .shade300, // Use theme color or grey if disabled
                    foregroundColor:
                        isButtonEnabled
                            ? Colors.white
                            : Colors.grey.shade600, // Text color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Enable button only if at least one interest is selected
                  onPressed:
                      isButtonEnabled
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const FeedPage(), // Replace with your next page
                              ),
                            );
                          }
                          : null, // Disable button if no interests are selected
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 30), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

// --- How to Navigate (Reminder) ---
// From the previous screen (e.g., GenderPage), navigate like this:
/*
Navigator.pushNamed(context, InterestsPage.routeName);
*/

// --- How to Add Route in main.dart (Reminder) ---
// In your main.dart's MaterialApp routes:
/*
MaterialApp(
  // ... other properties ...
  routes: {
    // ... other routes
    InterestsPage.routeName: (context) => const InterestsPage(),
    // ...
  },
)
*/
