import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically calculate the width of each card based on screen size
          double cardWidth;

          // Adjust card width based on screen size
          if (constraints.maxWidth > 1200) {
            cardWidth = (constraints.maxWidth / 5) - 10; // 5 items in a row for larger screens
          } else if (constraints.maxWidth > 800) {
            cardWidth = (constraints.maxWidth / 4) - 10; // 4 items in a row for medium screens
          } else if (constraints.maxWidth > 600) {
            cardWidth = (constraints.maxWidth / 3) - 10; // 3 items in a row for smaller tablets
          } else {
            cardWidth = (constraints.maxWidth / 2) - 10; // 2 items in a row for mobile screens
          }

          return SingleChildScrollView(
            child: Wrap(
              spacing: 8.0, // Space between items horizontally
              runSpacing: 8.0, // Space between items vertically
              children: List.generate(20, (index) {
                return Container(
                  width: cardWidth, // Set card width dynamically
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 4), // Shadow offset
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2), // Circular image
                              child: Image.network(
                                'https://png.pngtree.com/png-vector/20230928/ourmid/pngtree-young-indian-man-png-image_10149659.png', // Replace with the actual photo URL
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Name
                            Text(
                              'Room Name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // Name
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Dark color for contrast
                              ),
                            ),
                            Text(
                              'Manish Sahu',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // Name
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87, // Dark color for contrast
                              ),
                            ),
                            // Email
                            Text(
                              'john.doe@example.com',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // Email
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey, // Lighter text color
                              ),
                            ),
                            // City
                            Row(
                              children: [
                                Icon(Icons.location_city, size: 16, color: Colors.grey),
                                // City icon
                                SizedBox(width: 4),
                                Text(
                                  'New York City',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis, // City
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}