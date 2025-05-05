import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pineapple/app/feed/feed.dart';
import 'package:pineapple/login/create_account.dart';
import 'package:pineapple/login/otp/number.dart';
import 'package:pineapple/onboard/name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple, // Adjust primary color if needed
        scaffoldBackgroundColor: const Color(
          0xFFFFF8F0,
        ), // Light cream background
        fontFamily: 'Inter', // Example font, replace if needed
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive padding/margins
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          icon: const Icon(Icons.feed_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedPage()),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NamePage()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: screenWidth * 0.08,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Guest',
                style: TextStyle(
                  color: Color(0xFF4A0072), // Deep purple color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        // Ensures content is not obscured by notches/status bars
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
          ), // Responsive horizontal padding
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch buttons horizontally
            children: <Widget>[
              const Spacer(flex: 2), // Pushes content down a bit
              // --- Pineapple Image ---
              // Replace with your actual image asset
              // Make sure to add the image to your pubspec.yaml assets section
              Image.asset(
                'assets/pineapple_logo.png', // <<<--- IMPORTANT: Replace with your image path
                height: screenHeight * 0.15, // Responsive height
                errorBuilder: (context, error, stackTrace) {
                  // Placeholder if image fails to load
                  return Icon(
                    Icons.image_not_supported,
                    size: screenHeight * 0.15,
                    color: Colors.grey,
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02), // Spacing
              // --- "Pineapple" Text ---
              const Text(
                'Pineapple',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A0072), // Deep purple color
                ),
              ),
              const Spacer(flex: 3), // More space before the legal text
              // --- Legal Text ---
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700], // Default text color
                    height: 1.5, // Line spacing
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text:
                          'By tapping Sign in or Create account, you agree to our ',
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: Color(0xFF6200EE), // Purple link color
                        decoration: TextDecoration.underline,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Implement navigation or show Terms of Service
                              print('Terms of Service tapped');
                            },
                    ),
                    const TextSpan(
                      text: '. Learn how we process your data in our ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        color: Color(0xFF6200EE), // Purple link color
                        decoration: TextDecoration.underline,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Implement navigation or show Privacy Policy
                              print('Privacy Policy tapped');
                            },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Cookie Policy',
                      style: const TextStyle(
                        color: Color(0xFF6200EE), // Purple link color
                        decoration: TextDecoration.underline,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Implement navigation or show Cookie Policy
                              print('Cookie Policy tapped');
                            },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04), // Spacing
              // --- Create Account Button ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6200EE), // Purple background
                  foregroundColor: Colors.white, // White text
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen(),
                    ),
                  );
                },
                child: const Text('Create account'),
              ),
              SizedBox(height: screenHeight * 0.02), // Spacing
              // --- Sign In Button ---
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6200EE), // Purple text
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OtpScreen()),
                  );
                },
                child: const Text('Sign in'),
              ),
              const Spacer(flex: 1), // Add some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
