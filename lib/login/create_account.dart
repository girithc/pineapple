import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  // Define a static route name for easy access within the app's routes
  static const String routeName =
      '/create_account'; // Or '/login' depending on your route naming

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // State variables to manage UI interaction
  bool _keepLoggedIn = false; // For the checkbox state
  bool _obscurePassword = true; // For password field visibility

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive padding
    final screenWidth = MediaQuery.of(context).size.width;
    // Access the theme defined in main.dart
    final theme = Theme.of(context);

    return Scaffold(
      // Add an AppBar for navigation context (optional)
      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor, // Use theme background color
        elevation: 0, // Remove shadow for a flat look
        leading: IconButton(
          // Standard back button
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ), // Themed back arrow
          onPressed: () => Navigator.of(context).pop(), // Navigate back action
        ),
        // You could add a title here if needed: title: Text('Create Account'),
      ),
      // Use SafeArea to avoid OS intrusions (status bar, notch)
      body: SafeArea(
        child: SingleChildScrollView(
          // Enable scrolling for smaller screens or long content
          child: Padding(
            // Apply horizontal padding based on screen width, and some vertical padding
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Make buttons stretch full width
              children: <Widget>[
                // --- Title "Create an account" ---
                Align(
                  // Align the title to the start (left)
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create an account', // Title text
                    style: TextStyle(
                      fontSize: 24, // Title font size
                      fontWeight: FontWeight.bold, // Bold weight
                      color: Color(0xFF4A0072), // Specific dark purple color
                    ),
                  ),
                ),
                const SizedBox(height: 25), // Spacing below title
                // --- Email Label ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // Label text for the email field
                    'Email or username',
                    style: TextStyle(
                      fontSize: 14, // Label font size
                      fontWeight: FontWeight.w500, // Medium weight
                      color: Colors.black54, // Subdued text color
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Spacing between label and field
                // --- Email Input Field ---
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email or username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Adjust the radius as needed
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ), // Optional: change border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: const Color(0xFF6200EE),
                      ), // Optional: focused color
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Spacing below email field
                // --- Password Label ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // Label text for the password field
                    'Password',
                    style: TextStyle(
                      fontSize: 14, // Label font size
                      fontWeight: FontWeight.w500, // Medium weight
                      color: Colors.black54, // Subdued text color
                    ),
                  ),
                ),
                const SizedBox(height: 8), // Spacing between label and field
                // --- Password Input Field ---
                TextField(
                  obscureText:
                      _obscurePassword, // Control visibility using state variable
                  decoration: InputDecoration(
                    // Use InputDecoration defined in the theme
                    hintText: 'Password', // Placeholder text
                    // Style is inherited from theme.inputDecorationTheme
                    suffixIcon: IconButton(
                      // Add icon button to toggle visibility
                      icon: Icon(
                        // Change icon based on visibility state
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey, // Icon color
                      ),
                      onPressed: () {
                        // Toggle the visibility state when icon is pressed
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Adjust the radius as needed
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ), // Optional: change border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: const Color(0xFF6200EE),
                      ), // Optional: focused color
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Spacing below password field
                // --- Keep me logged in Checkbox ---
                Row(
                  // Arrange checkbox and label horizontally
                  children: <Widget>[
                    SizedBox(
                      // Constrain checkbox size for better alignment
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _keepLoggedIn, // Bind value to state variable
                        onChanged: (bool? value) {
                          // Update state when checkbox is toggled
                          setState(() {
                            _keepLoggedIn = value ?? false;
                          });
                        },
                        // Style is inherited from theme.checkboxTheme
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ), // Spacing between checkbox and text
                    const Text(
                      // Label for the checkbox
                      'Keep me logged in',
                      style: TextStyle(
                        fontSize: 14, // Label font size
                        color: Colors.black87, // Text color
                      ),
                    ),
                  ],
                ), // End of Row for checkbox
                const SizedBox(height: 25), // Spacing below checkbox row
                // --- Log in Button ---
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement actual Login Logic here
                    print('Log in button pressed');
                    // Example: Validate fields, call authentication service
                  },
                  style: ElevatedButton.styleFrom(
                    // Use ElevatedButton style defined in the theme
                    backgroundColor: const Color(
                      0xFF6200EE,
                    ), // Purple background
                    foregroundColor: Colors.white, // White text
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ), // Padding for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  // Style is inherited from theme.elevatedButtonTheme
                  child: const Text('Log in'), // Button text
                ),
                const SizedBox(height: 30), // Spacing below login button
                // --- Social Login Buttons Section ---

                // Google Login Button
                OutlinedButton.icon(
                  icon: Image.asset(
                    // Use a specific Google icon asset
                    'assets/google_icon.png', // <<<--- Replace with your Google icon path
                    height: 20.0, // Icon height
                    width: 20.0, // Icon width
                    // Provide a fallback icon if the image asset fails to load
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.g_mobiledata,
                          size: 24,
                          color: Colors.redAccent,
                        ), // Placeholder icon
                  ),
                  label: const Text('Login with Google'), // Button text
                  onPressed: () {
                    // TODO: Implement Google Login flow
                    print('Google login pressed');
                  },
                  style: OutlinedButton.styleFrom(
                    // Use OutlinedButton style defined in the theme
                    backgroundColor: Colors.white, // White background
                    foregroundColor: Colors.black87, // Black text
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ), // Padding for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  // Style is inherited from theme.outlinedButtonTheme
                ),
                const SizedBox(height: 15), // Spacing between social buttons
                // Facebook Login Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    // Use OutlinedButton style defined in the theme
                    backgroundColor: Colors.white, // White background
                    foregroundColor: Colors.black87, // Black text
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ), // Padding for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  icon: Image.asset(
                    // Use a specific Facebook icon asset
                    'assets/facebook_icon.png', // <<<--- Replace with your Facebook icon path
                    height: 20.0, // Icon height
                    width: 20.0, // Icon width
                    // Provide a fallback icon if the image asset fails to load
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.facebook,
                          size: 24,
                          color: Colors.blueAccent,
                        ), // Placeholder icon
                  ),
                  label: const Text('Login with Facebook'), // Button text
                  onPressed: () {
                    // TODO: Implement Facebook Login flow
                    print('Facebook login pressed');
                  },
                  // Style is inherited from theme.outlinedButtonTheme
                ),
                const SizedBox(height: 15), // Spacing between social buttons
                // Apple Login Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    // Use OutlinedButton style defined in the theme
                    backgroundColor: Colors.white, // White background
                    foregroundColor: Colors.black87, // Black text
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ), // Padding for button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  icon: Image.asset(
                    // Use a specific Apple icon asset
                    'assets/apple_icon.png', // <<<--- Replace with your Apple icon path
                    height: 20.0, // Icon height
                    width: 20.0, // Icon width
                    // Provide a fallback icon if the image asset fails to load
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.apple,
                          size: 24,
                          color: Colors.black87,
                        ), // Placeholder icon
                  ),
                  label: const Text('Login with Apple ID'), // Button text
                  onPressed: () {
                    // TODO: Implement Apple Login flow
                    print('Apple login pressed');
                  },
                  // Style is inherited from theme.outlinedButtonTheme
                ),
                const SizedBox(
                  height: 20,
                ), // Add some padding at the very bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
