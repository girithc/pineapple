import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String event;
  final String distance;
  final VoidCallback onTap;
  final VoidCallback onMessageTap;

  const MatchCard({
    required this.imageUrl,
    required this.name,
    required this.event,
    required this.distance,
    required this.onTap,
    required this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        // Uses CardTheme defined in MyApp
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch items horizontally
          children: [
            // Image section
            Expanded(
              flex: 3, // Give more space to the image
              child: ClipRRect(
                // Clip image to card's rounded corners
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12.0),
                ), // Only round top corners
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover, // Cover the area
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: CupertinoActivityIndicator()),
                    );
                  },
                ),
              ),
            ),
            // Text and Button Section
            Expanded(
              flex: 2, // Give less space to text
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Distribute space
                  children: [
                    // Event Tag (similar style to chat list item)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1), // Lighter yellow/beige
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        event,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE65100), // Orange text
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Name and Message Icon Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          // Allow name to take available space
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Message Icon Button
                        InkWell(
                          // Smaller tappable area for the icon
                          onTap: onMessageTap,
                          customBorder: const CircleBorder(),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              CupertinoIcons.chat_bubble_text, // Message icon
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Distance Text
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
