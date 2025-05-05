import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart'; // Import the package

class OtpVerifyScreen extends StatefulWidget {
  // Define a static route name
  static const String routeName = '/otp_verify';

  // Receive the phone number from the previous screen
  final String phoneNumber;

  const OtpVerifyScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String _enteredOtp = ""; // To store the entered OTP

  // Function to format the phone number for display (e.g., +91 9xxxxxxx9)
  String _formatPhoneNumber(String number) {
    if (number.length >= 10) {
      // Assuming a 10-digit number after the country code if included
      // This is a basic example, adjust based on your actual number format
      String lastDigits = number.substring(number.length - 1);
      String firstDigit = number.substring(
        number.length - 10,
        number.length - 9,
      );
      String countryCode =
          number.length > 10
              ? number.substring(0, number.length - 10)
              : "+91"; // Default or extract
      return "$countryCode $firstDigit$lastDigits";
    }
    return number; // Return original if too short
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions and theme
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      // Optional AppBar
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Optional Title
        // title: Text('Pineapple', style: TextStyle(color: Color(0xFF4A0072), fontWeight: FontWeight.bold)),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- Title "OTP verification" ---
              Text(
                'OTP verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A0072), // Dark purple
                ),
              ),
              const SizedBox(height: 15),

              // --- Description Text with formatted phone number ---
              Text(
                'Enter the OTP sent to ${_formatPhoneNumber(widget.phoneNumber)}', // Use the passed phone number
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),

              // --- OTP Input Fields ---
              OtpTextField(
                numberOfFields: 4, // Number of OTP boxes
                borderColor:
                    Colors.grey.shade400, // Border color for inactive fields
                focusedBorderColor:
                    theme
                        .primaryColor, // Border color when focused (use theme color)
                fieldWidth:
                    (screenWidth * 0.84 - 32) /
                    4, // Calculate width based on padding and spacing
                // Adjust spacing if needed: mainAxisAlignment: MainAxisAlignment.spaceBetween,
                showFieldAsBox: true, // Display as boxes
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                borderRadius: BorderRadius.circular(
                  8.0,
                ), // Rounded corners for boxes
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  setState(() {
                    _enteredOtp = verificationCode;
                  });
                  print("Entered OTP: $verificationCode");
                  // You can automatically trigger verification here if needed
                  // _verifyOtp(verificationCode);
                }, // end onSubmit
              ), // End of OtpTextField
              const SizedBox(height: 25),

              // --- Resend OTP Text ---
              Align(
                alignment: Alignment.centerLeft, // Align to the start
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement Resend OTP Logic
                    print('Resend OTP tapped');
                    // Example: Call API to resend OTP, maybe start a timer
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size(50, 30), // Make tap target reasonable
                    alignment: Alignment.centerLeft, // Align text inside button
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ), // Inherit default style
                      children: [
                        TextSpan(
                          text: "Didn't receive the OTP? ",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyle(
                            color:
                                theme
                                    .primaryColor, // Use theme's primary color for link
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(), // Pushes the button to the bottom
              // --- Verify Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _enteredOtp.length == 4
                          ? () {
                            // Enable button only when OTP is fully entered
                            // TODO: Implement OTP Verification Logic
                            print(
                              'Verify & Proceed button pressed with OTP: $_enteredOtp',
                            );
                            // Example: Call API to verify OTP
                            // If successful, navigate to the next part of the app
                            // Navigator.pushReplacementNamed(context, '/home'); // Example navigation
                          }
                          : null, // Disable button if OTP length is not 4
                  // Style inherited from theme.elevatedButtonTheme
                  child: Text(
                    'Verify & Proceed',
                    style: TextStyle(
                      color:
                          _enteredOtp.length == 4
                              ? Colors.white
                              : Colors.black54,
                    ),
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

              SizedBox(height: 30), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  // --- Optional: Placeholder for verification logic ---
  // void _verifyOtp(String otp) {
  //   // TODO: Implement API call to verify the OTP
  //   print("Verifying OTP: $otp");
  //   // Handle success/failure and navigation
  // }
}
