// otp_screen.dart
// (Place this class in its own file named otp_screen.dart)
// Assumes it's part of the app structure defined in main.dart,
// inheriting the theme and being called via navigation.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pineapple/login/otp/verify.dart'; // Required for input formatters

class OtpScreen extends StatelessWidget {
  // Define a static route name for easy access within the app's routes
  static const String routeName = '/otp';

  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and theme
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context); // Access the theme from main.dart

    return Scaffold(
      // Optional AppBar for back navigation
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
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the left
            children: <Widget>[
              Text(
                'OTP verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A0072), // Dark purple
                ),
              ),
              const SizedBox(height: 15), // Spacing
              // --- Description Text ---
              Text(
                'We will send you an One time Password on this mobile number',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700], // Subdued text color
                  height: 1.4, // Line spacing
                ),
              ),
              const SizedBox(height: 35), // Spacing
              // --- Mobile Number Label ---
              Text(
                'Enter mobile number',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10), // Spacing
              // --- Mobile Number Input Row ---
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: <Widget>[
                  // --- Country Code Field (Non-Editable) ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Background color
                      border: Border.all(color: Colors.grey.shade400), // Border
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ), // Rounded corners
                    ),
                    child: const Text(
                      '+91', // Static country code
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between fields
                  // --- Phone Number Input Field (Editable) ---
                  Expanded(
                    // Allows the text field to take remaining space
                    child: TextField(
                      keyboardType:
                          TextInputType.phone, // Use phone number keyboard
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Allow only digits
                        LengthLimitingTextInputFormatter(
                          10,
                        ), // Limit length (e.g., 10 digits for India)
                      ],
                      decoration: InputDecoration(
                        hintText: 'Mobile Number', // Placeholder

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 12.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 16), // Match text size
                    ),
                  ),
                ],
              ), // End of Row for mobile input

              const Spacer(), // Pushes the button to the bottom
              // --- Get OTP Button ---
              SizedBox(
                // Ensure button stretches full width
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const OtpVerifyScreen(phoneNumber: ''),
                      ),
                    );
                  },
                  // Style inherited from theme.elevatedButtonTheme
                  child: const Text(
                    'Get OTP',
                    style: TextStyle(color: Colors.white),
                  ),
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
                ),
              ),
              const SizedBox(height: 30), // Padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
