// gender_page.dart
// (Place this class in its own file named gender_page.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation.

import 'package:flutter/material.dart';
import 'package:pineapple/onboard/interest.dart';

class GenderPage extends StatefulWidget {
  // Define a static route name for easy access
  static const String routeName = '/gender_page';

  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  // State variable to store the selected gender. Null means nothing selected.
  String? _selectedGender;

  // List of gender options
  final List<String> _genderOptions = ['Man', 'Woman', 'Other'];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and theme
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    // Determine if the button should be enabled
    final bool isButtonEnabled = _selectedGender != null;

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
          'Your Gender', // Page title
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
                'Select your gender',
                style: TextStyle(
                  fontSize: 18, // Adjust size as needed
                  fontWeight: FontWeight.w500, // Medium weight
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 25), // Spacing
              // --- Gender Selection Options ---
              // Using Column for simple vertical list of options
              Column(
                children:
                    _genderOptions.map((gender) {
                      bool isSelected = _selectedGender == gender;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                        ), // Spacing between options
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                          child: Container(
                            width: double.infinity, // Make container stretch
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? theme.primaryColor.withOpacity(0.1)
                                      : Colors.white,
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
              ),

              const Spacer(), // Pushes the button towards the bottom
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
                  // Enable button only if a gender is selected
                  onPressed:
                      isButtonEnabled
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InterestsPage(),
                              ),
                            ); // Navigate to interests page
                          }
                          : null, // Disable button if no gender is selected
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
// From the previous screen (e.g., NamePage), navigate like this:
/*
Navigator.pushNamed(context, GenderPage.routeName);
*/

// --- How to Add Route in main.dart (Reminder) ---
// In your main.dart's MaterialApp routes:
/*
MaterialApp(
  // ... other properties ...
  routes: {
    // ... other routes
    GenderPage.routeName: (context) => const GenderPage(),
    // ...
  },
)
*/
