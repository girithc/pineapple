// name_page.dart
// (Place this class in its own file named name_page.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation.

import 'package:flutter/material.dart';
import 'package:pineapple/onboard/gender.dart';

class NamePage extends StatefulWidget {
  // Define a static route name for easy access
  static const String routeName = '/name_page';

  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  // Controller to manage the text field's content
  final TextEditingController _nameController = TextEditingController();
  // State variable to enable/disable the button
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the controller to enable the button when text is entered
    _nameController.addListener(() {
      setState(() {
        _isButtonEnabled = _nameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and theme
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      // Optional AppBar if back navigation is needed
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          // Consistent horizontal padding
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            // Center content horizontally within the column
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(flex: 1), // Add some space at the top
              // --- Placeholder Profile Image ---
              CircleAvatar(
                radius: screenHeight * 0.07, // Responsive radius
                backgroundColor: Colors.grey.shade300, // Placeholder color
                child: Icon(
                  Icons.person_outline, // Placeholder icon
                  size: screenHeight * 0.08, // Responsive icon size
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40), // Spacing
              // --- Prompt Text ---
              Text(
                'What do we call you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, // Adjust size as needed
                  fontWeight: FontWeight.w500, // Medium weight
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 25), // Spacing
              // --- Name Input Field ---
              TextField(
                controller: _nameController, // Use the text controller
                keyboardType: TextInputType.name, // Appropriate keyboard
                textCapitalization:
                    TextCapitalization.words, // Capitalize words
                textAlign: TextAlign.center, // Center the input text
                decoration: InputDecoration(
                  hintText: 'Your name', // Placeholder text
                  // Style inherited from theme.inputDecorationTheme
                  // Optionally customize border, fill color etc. if needed
                  // Example: Make border less prominent until focused
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   borderSide: BorderSide(color: Colors.grey.shade300), // Lighter border
                  // ),
                ),
                style: const TextStyle(fontSize: 16), // Input text style
              ),
              const Spacer(flex: 2), // Pushes the button towards the bottom
              // --- Continue Button ---
              SizedBox(
                width: double.infinity, // Make button stretch
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6200EE),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
                    ),
                  ),
                  // Enable button only if name field is not empty
                  onPressed:
                      _isButtonEnabled
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GenderPage(),
                              ),
                            );
                          }
                          : null, // Disable button if name is empty
                  // Style inherited from theme.elevatedButtonTheme
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: _isButtonEnabled ? Colors.white : Colors.black54,
                    ),
                  ),
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
// From the previous screen (e.g., OtpVerifyScreen), navigate like this:
/*
Navigator.pushNamed(context, NamePage.routeName);
*/

// --- How to Add Route in main.dart (Reminder) ---
// In your main.dart's MaterialApp routes:
/*
MaterialApp(
  // ... other properties ...
  routes: {
    // ... other routes
    NamePage.routeName: (context) => const NamePage(),
    // ...
  },
)
*/
