// The main ProfileEditPage widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  int _selectedSegment = 0; // 0 for Edit, 1 for View

  // Placeholder profile data - replace with actual data model
  final String profileImageUrl =
      'https://placehold.co/200x200/E0E0E0/grey?text=Profile'; // Placeholder
  final String name = 'Rehaan Kapadia';

  // Placeholder feed images - replace with actual data
  final List<Map<String, dynamic>> feedImages = [
    {
      'url': 'https://placehold.co/200x200/A0A0A0/white?text=Feed+1',
      'canDelete': true,
    },
    {
      'url': 'https://placehold.co/200x200/B0B0B0/white?text=Feed+2',
      'canDelete': true,
    },
    {
      'url': 'https://placehold.co/200x200/C0C0C0/white?text=Feed+3',
      'canDelete': true,
    },
    {'url': null, 'canDelete': false}, // Placeholder for Add button
  ];

  // Placeholder identity data
  final Map<String, String> identityData = {
    'About you': 'Lorem ipsum',
    'Your prompts': 'Lorem ipsum',
    'Gender': 'Male',
    'Sexuality': 'Straight',
    'Pronouns': 'He / him', // Assuming based on cut-off text
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
        // Assuming a back button would navigate here, so no explicit back button
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: IconButton(
            // Add a back button for navigation
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed:
                () => Navigator.of(context).pop(), // Standard back action
          ),
        ),
        title: Text('Edit Profile'), // Show first name in AppBar
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: TextButton(
              onPressed: () {
                // Handle Done action - save changes, navigate back etc.
                Navigator.of(context).pop(); // Example: just navigate back
              },
              child: const Text('Done'),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch children horizontally
            children: [
              // _buildEditViewButtons(),
              // Segmented Control
              Center(
                // Center the segmented control
                child: CupertinoSegmentedControl<int>(
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 32,
                      ),
                      child: Text('Edit'),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 32,
                      ),
                      child: Text('View'),
                    ),
                  },
                  onValueChanged: (int newValue) {
                    setState(() {
                      _selectedSegment = newValue;
                      // Potentially switch between edit/view modes or navigate
                    });
                  },
                  groupValue: _selectedSegment,
                  selectedColor:
                      Theme.of(
                        context,
                      ).scaffoldBackgroundColor, // Match background
                  unselectedColor: Colors.transparent, // Transparent unselected
                  borderColor: Colors.transparent, // No border
                  pressedColor: Colors.grey.withOpacity(0.1),
                  // Add an indicator below the selected segment
                  // This requires a custom implementation or a package like `custom_sliding_segmented_control`
                  // For simplicity, we'll omit the underline indicator here.
                ),
              ),
              const SizedBox(height: 24),

              // Profile Picture with Edit Icon
              Center(child: _buildProfilePicture()),
              const SizedBox(height: 16),

              // Name Display Field
              _buildNameField(),
              const SizedBox(height: 24),

              // My Feed Section
              _buildSectionTitle('My feed'),
              const SizedBox(height: 12),
              _buildFeedGrid(),
              const SizedBox(height: 24),

              // Identity Section
              _buildSectionTitle('Identity'),
              const SizedBox(height: 8),
              _buildIdentityList(),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
      // No bottom navigation bar in this specific screen based on screenshot
    );
  }

  // Helper widget for the profile picture
  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(profileImageUrl),
          onBackgroundImageError: (_, __) {
            /* Handle error */
          },
          backgroundColor: Colors.grey[300],
        ),
        // Edit Icon Overlay
        InkWell(
          onTap: () {
            /* Handle edit profile picture */
          },
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.deepPurple, // Or your theme's primary color
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for the name field
  Widget _buildNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper widget for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildEditViewButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        boxShadow: [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()),
              );
            },
            child: const Text(
              'Edit',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 24, // Adjust height as needed
            child: VerticalDivider(color: Colors.black, thickness: 1),
          ),
          TextButton(
            onPressed: () {
              /* Handle View profile */
            },
            child: const Text(
              'View',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the "My feed" image grid
  Widget _buildFeedGrid() {
    return GridView.builder(
      shrinkWrap: true, // Important inside SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0, // Square aspect ratio
      ),
      itemCount: feedImages.length,
      itemBuilder: (context, index) {
        final item = feedImages[index];
        return _FeedImageCard(
          imageUrl: item['url'],
          canDelete: item['canDelete'],
          onDelete: () {
            setState(() {
              // Handle image deletion - replace with actual logic
              feedImages.removeAt(index);
            });
          },
          onAdd: () {
            // Handle adding a new image
            print('Add image tapped');
          },
        );
      },
    );
  }

  // Helper widget for the "Identity" list
  Widget _buildIdentityList() {
    // Convert map to list for builder
    final identityItems = identityData.entries.toList();

    return ListView.separated(
      shrinkWrap: true, // Important inside SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(), // Disable list scrolling
      itemCount: identityItems.length,
      itemBuilder: (context, index) {
        final item = identityItems[index];
        return _IdentityRow(
          title: item.key,
          value: item.value,
          onTap: () {
            // Handle tapping on an identity row (e.g., navigate to edit screen)
            print('Tapped on ${item.key}');
          },
        );
      },
      separatorBuilder:
          (context, index) => const Divider(height: 1), // Add dividers
    );
  }
}

// --- Reusable Feed Image Card Widget ---

class _FeedImageCard extends StatelessWidget {
  final String? imageUrl; // Nullable for the Add button case
  final bool canDelete;
  final VoidCallback onDelete;
  final VoidCallback onAdd;

  const _FeedImageCard({
    required this.imageUrl,
    required this.canDelete,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    // If imageUrl is null, show the Add button card
    if (imageUrl == null) {
      return InkWell(
        onTap: onAdd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: const Center(
            child: Icon(Icons.add, size: 40, color: Colors.grey),
          ),
        ),
      );
    }

    // Otherwise, show the image card
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        fit: StackFit.expand, // Make stack fill the card
        children: [
          // Image
          Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
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
          // Delete Icon Button (Top Right)
          if (canDelete)
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: onDelete,
                customBorder: const CircleBorder(),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --- Reusable Identity Row Widget ---

class _IdentityRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _IdentityRow({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
